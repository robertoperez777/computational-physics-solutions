PROGRAM EXERCISE4_2
IMPLICIT NONE
    REAL :: J(0:50)
    REAL :: E(0:14)
    REAL :: X
    INTEGER :: NMAX
    INTEGER :: N
10  PRINT *,'ENTER MAX VALUE OF N (< 50; 0 TO STOP)'
    READ *,NMAX
    IF (NMAX < 0) STOP
    IF (NMAX > 50) NMAX=50
    PRINT *,'ENTER VALUE OF X'
    READ *,X
    J(NMAX)=0
    J(NMAX-1)=1E-20
    DO N=NMAX-1,1,-1
        J(N-1)=(2*N/X)*J(N)-J(N+1)
    END DO
    E(0)=.171073
    E(1)=.133375
    E(2)=-.15202
    E(3)=-.176809
    E(4)=.0762444
    E(5)=.220378
    E(6)=.0811682
    E(7)=-.150805
    E(8)=-.231973
    E(9)=-.114307
    E(10)=.0850067
    E(11)=.235746
    E(12)=.28545
    E(13)=.253598
    E(14)=.185517
    PRINT *,'          N           VALUE             ERROR'
    PRINT *,'NORMALIZED USING EQUATION 4.7'
    CALL NORM47(X,NMAX,J,E)
!    PRINT *,'NORMALIZED USING POLYNOMIAL APPROX.'
!    CALL NORMJ0(X,NMAX,J,E)
    GOTO 10
END PROGRAM

SUBROUTINE NORMJ0(X,NMAX,J,E)
IMPLICIT NONE
    REAL :: J(0:50)
    REAL :: E(0:14)
    REAL :: X
    REAL :: Y
    REAL :: NORM
    REAL :: THETA
    INTEGER :: NMAX
    INTEGER :: N
    Y=X/3.
    IF (X < 3) THEN
        NORM=1.-2.2499997*Y*Y+1.2656208*Y**4-.3163866*Y**6
        NORM=NORM+.0444479*Y**8-.039444*Y**10+.00021*Y**12
    ELSE
        NORM=.79788456-7.7E-7/Y-.0055274/Y**2-9.512E-5/Y**3
        NORM=NORM+1.37237E-3/Y**4-7.2805E-4/Y**5+1.4476E-4/Y**6
        THETA=X-.78539816-.04166397/Y-3.954E-5/Y**2+2.62573E-3/Y**3
        THETA=THETA-5.4125E-4/Y**4-2.9333E-4/Y**5+1.3558E-4/Y**6
        NORM=NORM*COS(THETA)/SQRT(X)
    END IF
    NORM=NORM/J(0)
    DO N=0,NMAX
        J(N)=NORM*J(N)
        PRINT *,N,J(N),J(N)-E(N)
    END DO
    RETURN
END SUBROUTINE

SUBROUTINE NORM47(X,NMAX,J,E)
IMPLICIT NONE
    REAL :: J(0:50)
    REAL :: E(0:14)
    REAL :: X
    REAL :: SUM
    INTEGER :: NMAX
    INTEGER :: N
    SUM=J(0)
    DO N=2,NMAX,2
        SUM=SUM+2*J(N)
    END DO
    DO N=0,NMAX
        J(N)=J(N)/SUM
        PRINT *,N,J(N),J(N)-E(N)
    END DO
    RETURN
END SUBROUTINE
