! Created by  on 01.12.23.

program fotranek
    CHARACTER(:), ALLOCATABLE :: line
    INTEGER :: lineLength, i, num1, num2
    INTEGER :: sum = 0

    ! Set an initial line length
    lineLength = 256

    ! Allocate the character array based on line length
    ALLOCATE(character(lineLength) :: line)

    ! Loop to read lines until end of file
    DO
        READ(*, '(A)', END = 100) line
        ! Get the actual length of the line
        lineLength = LEN_TRIM(line)
        ! Process or print the line and its length as needed


        DO i = 1, lineLength
            if (IACHAR(line(i:i))>=48 .AND. IACHAR(line(i:i)) <=57) then
                num1 = IACHAR(line(i:i)) - 48
                exit
            end if
        END DO
        forall (i = 1:lineLength) line(i:i) = line(lineLength - i + 1:lineLength - i + 1)
        DO i = 1, lineLength
            if (IACHAR(line(i:i))>=48 .AND. IACHAR(line(i:i)) <=57) then
                num2 = IACHAR(line(i:i)) - 48
                exit
            end if
        END DO

        PRINT *, "num1: ", num1, " num2: ", num2

        sum = sum + num1 * 10 + num2

    END DO

    100 CONTINUE
    PRINT *, "Result:", sum

    ! Deallocate the character array
    DEALLOCATE(line)

end program fotranek
