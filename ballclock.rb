#!/usr/bin/ruby

class Tray
  def initialize(size)
    @size = size
    @index = 0
    @storage = Array.new(size,0)
  end

  def add_ball(ball)
    return false if @index == @size
    @storage[@index] = ball
    @index += 1
  end

  def tilt(ballqueue)
    for i in (@size-1).downto(0)
      ballqueue.push(@storage[i])
      @storage[i] = 0
    end
    @index = 0
  end
end

def cycleballs(balls)
  days = 0

  ballqueue = Queue.new
  (1..balls).each {|ball| ballqueue.push(ball)}
  mintray = Tray.new(4)
  fivemintray = Tray.new(11)
  hourtray = Tray.new(11)

  dayflag = false
  
  while true
    # pull ball up to min 
    ball = ballqueue.pop
    # see if tilts min
    if !mintray.add_ball(ball)
      mintray.tilt(ballqueue)
      # see if tilts 5 min
      if !fivemintray.add_ball(ball)
        fivemintray.tilt(ballqueue)
        # see if tilts hours 
        if !hourtray.add_ball(ball)
          hourtray.tilt(ballqueue)
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
        end
      end
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

