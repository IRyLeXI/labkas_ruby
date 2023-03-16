def fact(n)
    return 1 if n <= 1
    n * fact(n-1)
end

def calculate(res, op, secnumber = nil)                                                                  #операції
    case op
    when "+"
        res += secnumber
    when "-"
        res -= secnumber
    when "*"
        res *= secnumber
    when "/"
        if secnumber == 0
            puts "Division by 0 error!"
            exit
        else
            res /= secnumber
        end
    when "--"
        res-=1    
    when "mod"
        res %= secnumber
    when "pow"
        res **= secnumber
    when "sqrt"
        res = Math.sqrt(res)
    when "sin"
        res = Math.sin(res)
    when "cos"
        res = Math.cos(res)
    when "tan"
        res = Math.tan(res)
    when "ctan"
        res = 1 / Math.tan(res)
    when "exp"
        res = Math.exp(res)
    when "ln"
        res = Math.log(res)
    when "!"
        if res<0
            puts "Number is less than zero!"
            exit
        else
            res=fact(res)
        end        
    else
        puts "There are no operations with this name!"
        exit
    end
    return res
end
  
puts "Calculator has started!"                                                                         #старт

memory = nil

puts "First number: "

res = gets.chomp.to_f

op=""

while op!="end"                                                                                         #цикл
    puts "Choose op +, -, *, /, mod, pow, sqrt, sin, cos, tan, ctan, exp, ln, !, memw, end"

    op = gets.chomp
  
    if op == "end"
        break
    end

    if op=="memw"
        puts "#{res} remembered"
        memory = res       
    else    
        if ["sqrt", "sin", "cos", "tan", "ctan", "exp", "ln", "!", "--"].include?(op)
            res = calculate(res, op)
        else
            puts "Second number (or memr)"
            secnumber = gets.chomp
            if secnumber=="memr"
                if memory==nil
                    puts "Error! No data!"
                    exit               
                else
                    secnumber = memory
                    puts secnumber
                end
            else
                secnumber=secnumber.to_f                   
            end
            res = calculate(res, op, secnumber)       
        end 
    puts "Result: #{res}"   
    end
    
end    