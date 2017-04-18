require "spec_helper"

describe Grid do
  let!(:grid) { Grid.new }

  describe "#grid" do
    it "returns a 6x7 grid (an array of arrays)" do
      expect(grid.grid).to eq([
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ["^", "^", "^", "^", "^", "^", "^"],
        ["A", "B", "C", "D", "E", "F", "G"]
      ])
    end
  end

  describe "#drop" do
    context "when it is given a column letter (A-G) and player piece (X or O)" do
      it "places the player's piece at the lowest open space in the selected column" do
        grid.drop("A", "X")
        expect(grid.grid).to eq([
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          ["X", nil, nil, nil, nil, nil, nil],
          ["^", "^", "^", "^", "^", "^", "^"],
          ["A", "B", "C", "D", "E", "F", "G"]
        ])
        grid.drop("B", "O")
        expect(grid.grid).to eq([
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          ["X", "O", nil, nil, nil, nil, nil],
          ["^", "^", "^", "^", "^", "^", "^"],
          ["A", "B", "C", "D", "E", "F", "G"]
        ])
        grid.drop("b", "X")
        expect(grid.grid).to eq([
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, "X", nil, nil, nil, nil, nil],
          ["X", "O", nil, nil, nil, nil, nil],
          ["^", "^", "^", "^", "^", "^", "^"],
          ["A", "B", "C", "D", "E", "F", "G"]
        ])
        grid.drop("G", "O")
        expect(grid.grid).to eq([
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, "X", nil, nil, nil, nil, nil],
          ["X", "O", nil, nil, nil, nil, "O"],
          ["^", "^", "^", "^", "^", "^", "^"],
          ["A", "B", "C", "D", "E", "F", "G"]
        ])
      end
    end

    context "when it is given bad arguments" do
      it "returns false if an argument is missing" do
        expect(grid.drop).to be false
        expect(grid.drop("A")).to be false
        expect(grid.drop("X")).to be false
      end

      it "returns false if argument is not a letter between A-G" do
        expect(grid.drop("H", "X")).to be false
        expect(grid.drop("AB", "X")).to be false
      end

      it "returns false if player piece is not X or O" do
        expect(grid.drop("A", "R")).to be false
      end
    end

    context "when a column is full" do
      it "returns false" do
        grid.drop("A", "X")
        grid.drop("A", "X")
        grid.drop("A", "X")
        grid.drop("A", "X")
        grid.drop("A", "X")
        grid.drop("A", "X")
        expect(grid.drop("A", "X")).to be false
      end
    end
  end

  describe "#show" do
    it "returns a put-able array of a visual representation of the current state of the grid" do
      expect(grid.show).to eq([
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| ^ | ^ | ^ | ^ | ^ | ^ | ^ |',
      '| A | B | C | D | E | F | G |'
      ])
      grid.drop("A", "X")
      grid.drop("B", "O")
      grid.drop("b", "X")
      grid.drop("G", "O")
      expect(grid.show).to eq([
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | - | - | - | - | - | - |',
      '| - | X | - | - | - | - | - |',
      '| X | O | - | - | - | - | O |',
      '| ^ | ^ | ^ | ^ | ^ | ^ | ^ |',
      '| A | B | C | D | E | F | G |'
      ])
    end
  end

  describe "#check" do
    context "when there is NO four-in-a-row" do
      it "returns false" do
        expect(grid.check("X")).to be false
      end
    end

    context "when there is a four-in-a-row HORIZONTAL" do
      it "returns true" do
        grid.drop("C", "O")
        grid.drop("D", "O")
        grid.drop("E", "O")
        grid.drop("F", "O")
        expect(grid.check("O")).to be true
      end
      it "returns true" do
        grid.drop("C", "O")
        grid.drop("D", "O")
        grid.drop("E", "O")
        grid.drop("F", "O")
        grid.drop("C", "O")
        grid.drop("D", "O")
        grid.drop("E", "O")
        grid.drop("F", "O")
        grid.drop("C", "O")
        grid.drop("D", "O")
        grid.drop("E", "O")
        grid.drop("F", "O")
        grid.drop("C", "X")
        grid.drop("D", "X")
        grid.drop("E", "X")
        grid.drop("F", "X")
        expect(grid.check("X")).to be true
      end
    end

    context "when there is a four-in-a-row VERTICAL" do
      it "returns true" do
        grid.drop("C", "X")
        grid.drop("C", "X")
        grid.drop("C", "X")
        grid.drop("C", "X")
        expect(grid.check("X")).to be true
      end
    end

    context "when there is a four-in-a-row FORWARD SLASH" do
      it "returns true" do
        grid.drop("C", "X")
        grid.drop("C", "X")
        grid.drop("C", "X")
        grid.drop("C", "O")
        grid.drop("D", "X")
        grid.drop("D", "X")
        grid.drop("D", "O")
        grid.drop("E", "X")
        grid.drop("E", "O")
        grid.drop("F", "O")
        expect(grid.check("O")).to be true
      end
    end

    context "when there is a four-in-a-row BACKWORD SLASH" do
      it "returns true" do
        grid.drop("C", "X")
        grid.drop("D", "O")
        grid.drop("D", "X")
        grid.drop("E", "O")
        grid.drop("E", "O")
        grid.drop("E", "X")
        grid.drop("F", "O")
        grid.drop("F", "O")
        grid.drop("F", "O")
        grid.drop("F", "X")
        expect(grid.check("X")).to be true
      end
    end
  end

  describe "#game_over" do
    context "when there are no more spaces left" do
      it "returns false immediately after the last space is taken" do
        6.times { grid.drop("A", "X") }
        6.times { grid.drop("B", "X") }
        6.times { grid.drop("C", "X") }
        6.times { grid.drop("D", "X") }
        6.times { grid.drop("E", "X") }
        6.times { grid.drop("F", "X") }
        6.times { grid.drop("G", "X") }
        expect(grid.game_over).to be true
      end
    end
  end
end
