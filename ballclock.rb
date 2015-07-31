#!/usr/bin/ruby


def tilt(array, ballqueue)
  for i in (array.length-1).downto(0)
    ballqueue.push(array[i])
    array[i] = 0
  end
end

def cycleballs(balls)
  mins = 0
  fivemins = 0
  hours = 0
  days = 0

  ballqueue = Queue.new
  (1..balls).each {|ball| ballqueue.push(ball)}
  minarray = Array.new(4,0)
  fiveminarray = Array.new(11,0)
  hourarray = Array.new(11,0)

  dayflag = false
  
  while true
    # pull ball up to min 
    ball = ballqueue.pop
    # see if tilts min
    if mins == 4
      mins = 0
      tilt(minarray,ballqueue)
      # see if tilts 5 min
      if fivemins == 11
        fivemins = 0
        tilt(fiveminarray,ballqueue)
        # see if tilts hours 
        if hours == 11
          hours = 0
          tilt(hourarray,ballqueue)
          ballqueue.push(ball)
          # is full day??
          if dayflag
            days += 1
            dayflag = false
          else
            dayflag = true
          end
          # check if balls are in original order

          ballarray = Array.new(balls,0)
          queuelen = ballqueue.length 
          for i in 0..queuelen-1
            orderball = ballqueue.pop
            ballarray[i] = orderball
            ballqueue.push(orderball)
          end
          if ballarray == ballarray.sort
            break
          end
        else
          hourarray[hours] = ball
          hours += 1
        end
      else
        fiveminarray[fivemins] = ball
        fivemins += 1
      end
    else
      minarray[mins] = ball
      mins += 1
    end
  end

  return days
end

while true do
  balls = gets.chomp.to_i
  if balls == 0
    break
  elsif balls >= 27 and balls <= 127
    days = cycleballs(balls)
    puts "#{balls} balls cycle after #{days} days."
  else
    puts "Invalid number of balls, please select a number between 27 and 127 inclusive"
  end
  
end

