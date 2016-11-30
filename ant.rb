# coding: iso-8859-1

=begin
# At a white square, turn 90° right, flip the color of the square, move forward one unit
# At a black square, turn 90° left, flip the color of the square, move forward one unit
detect, turn, switch, move repeat
=end

on = 1
off = 0

rows = 20
columns = 20

#makes an array containing #{row} arrays each containing #{col} switches in the off state.
grid = Array.new( rows ).map{ Array.new( columns, on ) }

row_set = column_set = Array.new << grid[0].map.with_index do |each, index|
  if index < 9
    "0#{ index + 1 }".ljust(2)
  else
    "#{ index + 1 }".ljust(2)
  end
end

downpointing_arrows = Array.new << grid[0].map.with_index do |each, index| "v" end

#if grid[x][y] is neither on nor off, how does can it still change value to 1?

class Ant #lives in the grid at position ( x, y )
  attr_accessor :x, :y, :grid, :facing

  def initialize
    @on = 1 #white
    @off = 0 #black
  end

  def is_at
    "R:#{x+1} C:#{y+1}"
  end

  def steer
    if grid[x][y] == @on
      :turn_right
    else grid[x][y]== @off
      :turn_left
    end
  end

  def turn
    if steer == :turn_left
      if @facing == :top
        @facing = :left
      elsif @facing == :left
        @facing = :bottom
      elsif @facing == :bottom
        @facing = :right
      elsif @facing == :right
        @facing = :top
      end
    elsif steer == :turn_right
      if @facing == :top
        @facing = :right
      elsif @facing == :right
        @facing = :bottom
      elsif @facing == :bottom
        @facing = :left
      elsif @facing == :left
        @facing = :top
      end
    end
  end

  def cell_state  
    if grid[x][y] == 0
      state = :Closed 
    else
      state = :Open
    end
  end
  
  def flip
    if grid[x][y] == @on
      grid[x][y] = @off
    else grid[x][y] == @off
      grid[x][y] = @on
    end
  end

  def move
    if facing == :top ###
      @x -= 1
    elsif facing == :right
      @y += 1
    elsif facing == :bottom
      @x += 1
    else facing == :left
      @y -= 1
    end
  end

end

#
x_input = 4 #row
y_input = 4 #column

x = x_input - 1
y = y_input - 1
  
ant = Ant.new
ant.x, ant.y, ant.grid, ant.facing = x, y, grid, :right #starting position and starting direction

puts

#method calls
40.times do  #40 moves...

  ant.cell_state
  
  print "#{ant.is_at} | Cell: #{ ant.cell_state } | Facing: #{ ant.facing } | #{ ant.steer } | "
  
  ant.turn
  ant.flip
  ant.move
  
  puts "Facing: #{ ant.facing } | Flipped & Moved." 
  puts "At: #{ant.is_at}"
  puts 
end

# GRIDding it down
puts "_" * "     #{ row_set.join( "  " )}".length
puts "     #{ row_set.join( "  " )}"
puts "      #{ downpointing_arrows.join( "   " )}"
puts

ant.grid.each.with_index do |each, index|
  if index < 9 
    puts "0#{index+1} " + ">  " + grid[index].join( "   " ) + "\n "
  else
    puts "#{index+1} " + ">  " + grid[index].join( "   " ) + "\n "
  end
end


