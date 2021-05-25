--Direction of the redstone
local sideOfArmor = "left" 

--Password of the redstone. Open Computers has the availablity to hash and encrypt but I don't know how I'm supposed to implement it
local password = "testing" 

--Tbh still don't know what this does but the documentation told me to do it so I did it
local component = require("component")

--Probably initilizes the database component, who knows. All I need to know is that it works
local db = component.database

--Gets the inventory controller and initilizes it, probably. Again, this is a new language with documentation that only semi makes sense
local inventoryController = component.inventory_controller

--The amount of time in seconds the redstone is on for
local redstoneTime = 5 


--Calculates the nummberOfDiamonds based on what is in the chest
function calculateNumberOfDiamonds(estNumDia)
    --init num of diamonds
    local numDiamonds = 0
    --For loops in lua look weird
    for i = 1, (estNumDia / 64) + 1, 1
        --gets the stackInfo of the inventory near by
        local currentInventory = inventoryController.getStackInSlot(sides.north, i)
        --Checks if the item is diamonds
        if(currentInventory[label] == "minecraft:diamond")
            --Add the number of diamonds to the stack number of diamonds
            numDiamonds += currentInventory[3]
        end
    end
    --Returns the number of diamonds based on the inventory info 
    return numDiamonds

end

function playerDiamondCheck()
    --Prints "Amount Of Diamonds: "
    write("Amount Of Diamonds: ")
    --Reads what the user types in
    local userInputMoney = read()

    --Prints "Make sure you put in the diamonds from top left to right"
    write("Make sure you put in the diamonds from top left to right")
    sleep(1)

    --Checks if user is done
    write("Once finished please type in any letter and hit enter")
    local temp = read()
    
    --Calcs the num of diamonds
    local numDia = calculateNumberOfDiamonds(userInputMoney)
    --Tells the user the diamonds has been counted
    write("counted")
    
    --Idk more documentation that doesn't exactly tell me what this does
    local io = require("io")
    local f = io.open("data.txt","w")
    --Writes data into the file
    f:write(numDia + "\n")
    f:close()
end
--loops
while true do
    --Clears Screen 
    term.clear() 
    --Sets the cursor to 1,1
    term.setCursorPos(1,1) 
    --Prints "Password" to the screen
    write("Password: ") 
    --Reads what the user types in
    local userInputPassword = read("*") 
    
    
    --Checks if the password is correct
    if userInputPassword == password then 
        --Clears Screen
        term.clear() 
        --Sets the Cursor position to 1,1
        term.setCursorPos(1,1)
        --Prints out that the password was correct
        print("Password correct!") 
        --Outputs the Redstone on the specific redstone on the top
        rs.setOutput(sideOfRedStone,true) 
        --Sleeps for the amount of time that you set restone time to
        sleep(redstoneTime)
        --Stops the redstone current
        rs.setOutput(sideOfRedStone,false) 
        playerDiamondCheck();

        

        -- if password was incorrect
    else 
        -- Prints 'Password incorrect!' to the screen
        print("Password incorrect!")
        --System stops for 2s
        sleep(2) 
    end
end

