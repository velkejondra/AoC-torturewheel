! Created by  on 01.12.23.

program part2
    CHARACTER(:), ALLOCATABLE :: line
    INTEGER :: lineLength, i, num1, num2, minindex, wordnum, numnum, smradoch, maxindex
    INTEGER :: sum = 0
    character(len = 10), dimension(10) :: numbers

    minindex = 1000000
    numbers = [character(len = 100) :: "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
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
        minindex = 1000000
        maxindex = -42
        DO smradoch = 1, lineLength
            if (IACHAR(line(smradoch:smradoch))>=48 .AND. IACHAR(line(smradoch:smradoch)) <=57) then
                numnum = IACHAR(line(smradoch:smradoch)) - 48
                exit
            end if
        END DO


        DO i = 1, 10
            if (index(line, trim(numbers(i))) > 0) then
                if (minindex > index(line, trim(numbers(i)))) then
                    minindex = index(line, trim(numbers(i)))
                    wordnum = i
                end if
            end if
        END DO
        if (minindex < smradoch) then
            num1 = wordnum - 1
        else
            num1 = numnum
        end if


        DO i = 1, 10
            if (index(line, trim(numbers(i))) > 0) then
                if (maxindex < index(line, trim(numbers(i)), BACK = .TRUE.)) then
                    maxindex = index(line, trim(numbers(i)), BACK = .TRUE.)
                    wordnum = i
                end if
            end if
        END DO

        forall (i = 1:lineLength) line(i:i) = line(lineLength - i + 1:lineLength - i + 1)

        DO smradoch = 1, lineLength
            if (IACHAR(line(smradoch:smradoch))>=48 .AND. IACHAR(line(smradoch:smradoch)) <=57) then
                numnum = IACHAR(line(smradoch:smradoch)) - 48
                exit
            end if
        END DO

        if (maxindex > lineLength + 1 -smradoch) then
            num2 = wordnum - 1
        else
            num2 = numnum
        end if

        PRINT *,  num1*10 + num2

        sum = sum + num1 * 10 + num2

    END DO

    100 CONTINUE
    PRINT *, "Result:", sum

    ! Deallocate the character array
    DEALLOCATE(line)

end program part2