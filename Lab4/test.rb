$stack =[]

def primes(n)
    for i in (1..n)
        isprime=true
        for j in (2..Math.sqrt(i).floor)
            if i%j==0
                isprime=false
                break
            end
        end
        if isprime
            $stack.push(i)
        end    
    end
end 
    



primes(23)

puts $stack