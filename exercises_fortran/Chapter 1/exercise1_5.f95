PROGRAM EXERCISE1_5
!   USES THE NEWTON RAPHSON AND SECANT METHODS FOR FINDING THE
!   ROOT FO A FUNCTION. THE DERIVATIVE IS REQUIRED FOR THE
!   NEWTON RAPHSON METHOD.
IMPLICIT NONE
    REAL :: X,TOLX

    TOLX = 1.E-06               !TOLERANCE FOR FINDING ROOT
    X = 1.67                    !INTITIAL GUESS
    CALL NEWTONRAPHSON(X,TOLX)

    X = 1.67
    CALL SECANT(X,TOLX)

END PROGRAM

SUBROUTINE NEWTONRAPHSON(X,TOLX)
IMPLICIT NONE
    REAL :: X,TOLX,FUNC,FPRIME
    INTEGER :: I

    I = 0
10  CONTINUE
    I = I+1
    X = X-FUNC(X)/FPRIME(X)
    IF (ABS(FUNC(X)) > TOLX) GOTO 10
    PRINT *,'NUMBER OF ITERATIONS',I
    PRINT *,"THE ROOT IS APPROIXATELY",X
    RETURN
END SUBROUTINE NEWTONRAPHSON

SUBROUTINE SECANT(X1,TOLX)
IMPLICIT NONE
    REAL :: X1,X2,XOLD,TOLX,FUNC
    INTEGER :: I

    I = 0
    X2 = X1+1               !RANDOM GUESS OF X2
20  CONTINUE
    I = I+1
    XOLD = X2
    X2 = X2-FUNC(X2)*(X2-X1)/(FUNC(X2)-FUNC(X1))
    X1 = XOLD
    IF (ABS(FUNC(X2)) > TOLX) GOTO 20
    PRINT *,'NUMBER OF ITERATIONS',I
    PRINT *,"THE ROOT IS APPROIXATELY",X2
    RETURN
END SUBROUTINE SECANT

FUNCTION FUNC(X)
    IMPLICIT NONE
    REAL :: FUNC,X
    FUNC = X**2-5.
    RETURN
END FUNCTION FUNC

FUNCTION FPRIME(X)
    IMPLICIT NONE
    REAL :: FPRIME,X
    FPRIME = 2.*X
    RETURN
END FUNCTION FPRIME
