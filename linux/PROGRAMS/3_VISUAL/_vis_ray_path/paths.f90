! This program visualize the rays corresponding to current calculations
! (from 'tmp' directory)
! Output:
! TMP_files/rays/rays_ver.dat : projection of rays in vertical section (as points)
! TMP_files/rays/ztr_ver.dat : projection of event coordinates in vertical section
! TMP_files/rays/rays_hor.dat : rays in a defined layer, z_up - z_low (as points)
! TMP_files/rays/ztr_hor.dat : sources in map view

character*8 ar,md,line
character*1 rm,it,ps
character*1 ver,lv,gr
real fmark(100),tmark(100)
real fia0(100),teta0(100),fib0(100),tetb0(100),dist_all(10)
real hlev(100),ornt(10)
real hmod(600),vmodp(600),vmods(600) ! ref. models in different zones

real ylev(2,390),xtop(2,10000,390), ztop(2,10000,390)
integer ntop(2,390),n_pop(2,10000,390),nyyy(2)

character*20 scale_line

common/stations/ xst(9000),yst(9000),zst(9000)
common /ray_path/npray,xray(5000),yray(5000),zray(5000)
common/refmod/nrefmod,hmod,vmodp,vmods
common/grid/zgrmax,dzlay,dsmin
common/pi/pi,per

one=1
pi=asin(one)*2.e0
per=pi/180.e0
rz=6371.

i=system('mkdir ..\..\..\TMP_files\rays')


open(1,file='../../../model.dat')
read(1,'(a8)')ar		! code of the area
read(1,'(a8)')md		! code of the area
close(1)
write(*,*)' ar=',ar,' md=',md


!******************************************************************
open(1,file='../../../DATA/'//ar//'/'//md//'/MAJOR_PARAM.DAT')
do i=1,10000
	read(1,'(a8)',end=573)line
	if(line.eq.'ORIENTAT') goto 574
end do
573 continue
write(*,*)' cannot find ORIENTATIONS in MAJOR_PARAM.DAT!!!'
pause
574 read(1,*)nornt
read(1,*)(ornt(i),i=1,nornt)
close(1)

iter=1
write(it,'(i1)')iter

                                                do igr=1,nornt

orient=ornt(igr)
sinal=sin(orient*per)
cosal=cos(orient*per)
write(*,*)' ***********************************************************************' 
write(*,*)' GRID NUMBER:',igr,' orient=',orient




write(gr,'(i1)')igr


!******************************************************************
key_ft1_xy2=1
open(1,file='../../../DATA/'//ar//'/'//md//'/MAJOR_PARAM.DAT')
do i=1,10000
    read(1,'(a8)',end=513)line
    if(line.eq.'GENERAL ') goto 514
end do
513 continue
write(*,*)' cannot find GENERAL INFORMATION in MAJOR_PARAM.DAT!!!'
pause
514 continue
read(1,*)
read(1,*)
read(1,*)
read(1,*)
read(1,*,end=441,err=441)key_ft1_xy2
read(1,*,end=441,err=441)key_true1
441 close(1)
!******************************************************************


open(2,file='../../../DATA/'//ar//'/setver.dat')
read(2,*)nver
do ii=1,nver
	read(2,*) fia0(ii),teta0(ii),fib0(ii),tetb0(ii)
end do
read(2,*) dist_from_sec_event
read(2,*) 
read(2,*) zmin,zmax,dzsec
close(2)

open(2,file='../../../DATA/'//ar//'/sethor.dat')
read(2,*) nlev  
read(2,*) (hlev(i),i=1,nlev)  
read(2,*) fmap1,fmap2,dfmap,tmap1,tmap2,dtmap  
close(2)

!open(1,file='../../../PROGRAMS/3_VISUAL/_vis_ray_path/SET.DAT')
!read(1,*)n_freq_ray=1
!read(1,*)n_freq_point=1
!close(1)

n_freq_ray=1
n_freq_point=1

write(it,'(i1)')iter

if(key_ft1_xy2.eq.1) then
    !******************************************************************
    open(1,file='../../../DATA/'//ar//'/'//md//'/MAJOR_PARAM.DAT')
    do i=1,10000
	    read(1,'(a8)',end=553)line
	    if(line.eq.'AREA_CEN') goto 554
    end do
    553 continue
    write(*,*)' cannot find AREA CENTER in MAJOR_PARAM.DAT!!!'
    pause
    554 read(1,*)fi0,tet0
    write(*,*)fi0,tet0
    close(1)
else
    fi0=0; tet0=0

end if


ntop=0
do iiips=1,2
	write(ps,'(i1)')iiips
	open(1,file='../../../DATA/'//ar//'/'//md//'/data/levinfo'//ps//gr//'.dat')
	i=0
	722 i=i+1
		read(1,*,end=721)n,ylev(iiips,i)
		goto 722
	721 nyyy(iiips)=i-1
	!write(*,*)' nlev=',nlev
	close(1)

	open(1,file='../../../DATA/'//ar//'/'//md//'/data/gr'//ps//gr//'.dat')

	do n=1,nyyy(iiips)
		read(1,*,end=556)ntop(iiips,n)
		!write(*,*)' y=',ylev(iiips,n),' ntop=',ntop(iiips,n)
		do i=1,ntop(iiips,n)
			read(1,*)xtop(iiips,i,n),ztop(iiips,i,n),n_pop(iiips,i,n)
		end do
	end do
	556		close(1)
end do

do iver=1,nver
	write(ver,'(i1)')iver
	fia=fia0(iver)
	fib=fib0(iver)
	teta=teta0(iver)
	tetb=tetb0(iver)
        if(key_ft1_xy2.eq.1) then
	    call SFDEC(fia,teta,0.,xa,ya,Z,fi0,tet0)
	    call SFDEC(fib,tetb,0.,xb,yb,Z,fi0,tet0)
        else
            xa=fia; ya=teta
            xb=fib; yb=tetb
        end if
	dist=sqrt((xb-xa)*(xb-xa)+(yb-ya)*(yb-ya))
	dist_all(iver)=dist
!write(*,*)' iver=',iver,' dist=',dist
	sinpov=(yb-ya)/dist
	cospov=(xb-xa)/dist
!write(*,*)' sinpov=',sinpov,' cospov=',cospov


	open(11,file='../../../TMP_files/rays/mark'//ver//'.dat')
	imark=0
	dsmark=50.
	do sss=0.,dist,dsmark
		x=xa+cospov*sss
		y=ya+sinpov*sss
                if(key_ft1_xy2.eq.1) then
	            call decsf(x,y,0.,fi0,tet0,FI,TET,h)
                else
                    fi=x
                    tet=y
                end if
		write(11,*)fi,tet,sss
		imark=imark+1
		fmark(imark)=fi
		tmark(imark)=tet
	end do
	close(11)

	! Draw the position of the section on the surface (line)
	open(11,file='../../../TMP_files/rays/mark'//ver//'.bln')
	write(11,*) imark+1
	do i=1,imark
		write(11,*)fmark(i),tmark(i)
	end do

        if(key_ft1_xy2.eq.1) then
	    call decsf(xb,yb,0.,fi0,tet0,FI,TET,h)
        else
            fi=xb
            tet=yb
        end if

	write(11,*)fi,tet,dist
	close(11)


	! Read the coordinates of the stations
	open(2,file='../../../DATA/'//ar//'/'//md//'/data/stat_xy.dat')
	open(12,file='../../../TMP_files/rays/stat_ver'//ver//'.dat')
	i=0
	3	i=i+1
		read(2,*,end=4)xst(i),yst(i),zst(i)
		xx1=(xst(i)-xa)*cospov+(yst(i)-ya)*sinpov
		yy1=-(xst(i)-xa)*sinpov+(yst(i)-ya)*cospov
		if(abs(yy1).lt.dist_from_sec_event)write(12,*)xx1,-1
		goto 3
	4	close(2)
	nst=i-1
!write(*,*)' nst=',nst
	close(12)

	open(1,file='../../../DATA/'//ar//'/'//md//'/data/rays'//it//'.dat',form='unformatted')
	open(2,file='../../../TMP_files/tmp/ray_paths_'//it//'.dat',form='unformatted')

	open(21,file='../../../TMP_files/rays/rays_ver1'//ver//'.dat')
	open(22,file='../../../TMP_files/rays/rays_ver2'//ver//'.dat')
	open(12,file='../../../TMP_files/rays/ztr_ver'//ver//'.dat')


	do iiips=1,2
		write(ps,'(i1)')iiips
		open(11,file='../../../TMP_files/rays/nodes_ver'//gr//ps//ver//'.dat')
		do n=1,nyyy(iiips)
			y=ylev(iiips,n)
			!write(*,*)' y=',ylev(iiips,n),' ntop=',ntop(iiips,n)
			do i=1,ntop(iiips,n)
				x=xtop(iiips,i,n)
				z=ztop(iiips,i,n)
				nppp=n_pop(iiips,i,n)
				if(nppp.eq.0) cycle


				xx=x*cosal-y*sinal
				yy=x*sinal+y*cosal

				xx1=(xx-xa)*cospov+(yy-ya)*sinpov
				yy1=-(xx-xa)*sinpov+(yy-ya)*cospov

				if(abs(yy1).lt.dist_from_sec_event) then
					write(11,*)xx1,-z,abs(yy1)
				end if

			end do
		end do

		close(11)
	end do


	izt=0
	nkrmax=0
	nray=0
	nrr=0
	nptot=0
	nrtot=0
	! Read the sources:
872	continue
	        if(key_true1.eq.1) read(1,end=871)xtrue,ytrue,ztrue
	        read(1,end=871)xzt,yzt,zzt,nkrat
		ind=1
		xx1=(xzt-xa)*cospov+(yzt-ya)*sinpov
		yy1=-(xzt-xa)*sinpov+(yzt-ya)*cospov
		if(abs(yy1).lt.dist_from_sec_event) write(12,*)xx1,-zzt,abs(yy1)
		nnn=0

		do ikr=1,nkrat


			read(1)ips,ist,tobs,tmod
			read(2)npray
			if(npray.eq.0)cycle
			nrr=nrr+1
			do i=1,npray
				read(2)xray(i),yray(i),zray(i)
			end do
			if(mod(nrr,n_freq_ray).eq.0) then
				nrtot=nrtot+1
				do ip=1,npray
					nnn=nnn+1
					if(mod(nnn+nray,n_freq_point).ne.0) cycle
					x=xray(ip)
					y=yray(ip)
					z=zray(ip)
					!write(*,*)x,y,z
					xx=(x-xa)*cospov+(y-ya)*sinpov
					yy=-(x-xa)*sinpov+(y-ya)*cospov
					
					nfile=21
					if(ips.eq.2)nfile=22

					if(abs(yy).lt.dist_from_sec_event)then
						nptot=nptot+1
						write(nfile,*)xx,-z
					end if
				end do
			end if

			nray=nray+1
		end do
		goto 872
	871	continue
	close(1)
	close(2)
	close(21)
	close(22)
	close(12)
	write(*,*)iver,' dist=',dist,' nrtot=',nrtot,' nptot=',nptot

end do ! iver=1,nver

do ilev=1,nlev
	write(lv,'(i1)')ilev

	if(ilev.eq.1) then
		zlev1=-10
		zlev2=(hlev(1)+hlev(2))/2
	else if(ilev.eq.nlev) then
		zlev1=(hlev(nlev-1)+hlev(nlev))/2
		zlev2=hlev(nlev) + (hlev(nlev)-hlev(nlev-1))/2
	else 
		zlev1=(hlev(ilev-1)+hlev(ilev))/2
		zlev2=(hlev(ilev+1)+hlev(ilev))/2
	end if

	do iiips=1,2
		write(ps,'(i1)')iiips
		open(11,file='../../../TMP_files/rays/nodes_hor'//gr//ps//lv//'.dat')
		do n=1,nyyy(iiips)
			y=ylev(iiips,n)
			!write(*,*)' y=',ylev(iiips,n),' ntop=',ntop(iiips,n)
			do i=1,ntop(iiips,n)
				x=xtop(iiips,i,n)
				z=ztop(iiips,i,n)
				nppp=n_pop(iiips,i,n)
				if(nppp.eq.0) cycle
				if((z-zlev1)*(z-zlev2).gt.0.) cycle
				xx=x*cosal-y*sinal
				yy=x*sinal+y*cosal
                                if(key_ft1_xy2.eq.1) then
	                            call decsf(xx,yy,0.,fi0,tet0,FI,TET,h)
                                else
                                    fi=xx
                                    tet=yy
                                end if
				write(11,*)fi,tet
			end do
		end do

		close(11)
	end do


	open(1,file='../../../DATA/'//ar//'/'//md//'/data/rays'//it//'.dat',form='unformatted')
	open(2,file='../../../TMP_files/tmp/ray_paths_'//it//'.dat',form='unformatted')


	open(11,file='../../../TMP_files/rays/rays_hor1'//lv//'.dat')
	open(21,file='../../../TMP_files/rays/rays_hor2'//lv//'.dat')
	open(12,file='../../../TMP_files/rays/ztr_hor'//lv//'.dat')



	izt=0
	nkrmax=0
	nray=0
	nrr=0
	! Read the sources:
672	continue
	        if(key_true1.eq.1) read(1,end=671)xtrue,ytrue,ztrue
	        read(1,end=671)xzt,yzt,zzt,nkrat

		if((zzt-zlev1)*(zzt-zlev2).le.0) then
                        if(key_ft1_xy2.eq.1) then
	                    call decsf(xzt,yzt,0.,fi0,tet0,FI,TET,h)
                        else
                            fi=xzt
                            tet=yzt
                        end if
			write(12,*)fi,tet,zzt
		end if

		do ikr=1,nkrat

			nnn=0

			read(1)ips,ist,tobs,tmod
			read(2)npray
			if(npray.eq.0)cycle
			nrr=nrr+1
			do i=1,npray
				read(2)xray(i),yray(i),zray(i)
			end do
			if(mod(nrr,n_freq_ray).eq.0) then
				nrtot=nrtot+1
				do i=1,npray
					nnn=nnn+1
					if(mod(nnn+nray,n_freq_point).ne.0) cycle
					if((zray(i)-zlev1)*(zray(i)-zlev2).gt.0.) cycle

					nptot=nptot+1

                                    if(key_ft1_xy2.eq.1) then
 					   call decsf(xray(i),yray(i),0.,fi0,tet0,FI,TET,h)
                                   else
                                        fi=xray(i)
                                        tet=yray(i)
                                    end if


					nfile=11
					if(ips.eq.2)nfile=21
					write(nfile,*)fi,tet
				end do
			end if

			nray=nray+1
		end do
		goto 672
	671	continue
	close(1)
	close(2)
	close(11)
	close(21)
	close(12)
	write(*,723)ilev,zlev1,zlev2,nrtot,nptot
723 format(' ilev=',i2,' z1=',f7.1,' z2=',f7.1,' nrtot=',i7,' nptot=',i8)

end do   ! ilev=1,nlev
					end do
stop
end
