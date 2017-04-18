class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    if piece.upcase == 'X' || piece.upcase == 'O'
      @piece = piece.upcase
    else
      while @piece != 'X' && @piece != 'O'
        print "Please enter valid piece (X or O): "
        @piece = gets.chomp
      end
    end
  end
end
