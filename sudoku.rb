require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'

enable :sessions

def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9,0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
end

def puzzle(sudoku)
  # This method removes some digits form the puzzle to create a solution
  # This method is yours to implement
end

get '/' do
  sudoku = random_sudoku
  session[:sudoku] = sudoku
  @current_solution = puzzle(sudoku)
  erb :index
end

get '/solution' do
  @current_solution = session[:sudoku]
  erb :index
end