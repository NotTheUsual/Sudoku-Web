require 'sinatra'
require 'sinatra/partial'
require 'rack-flash'
require_relative './lib/sudoku'
require_relative './lib/cell'
require_relative './helpers/application.rb'

set :partial_template_engine, :erb
set :session_secret, "I am the secret key to sign the cookie"
enable :sessions
use Rack::Flash

configure :production do
  require 'newrelic_rpm'
end

def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9,0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
end

def puzzle(sudoku)
  # This method removes some digits form the puzzle to create a solution
  # This method is yours to implement
  if @difficulty == "hard"
    indices = (0..80).to_a.sample(rand(55..65))
  else
    indices = (0..80).to_a.sample(rand(45..55))
  end
  
  
  sudoku.map.with_index { |c,i| indices.include?(i) ? c = "" : c }
end

def box_order_to_row_order(cells)
  boxes = cells.each_slice(9).to_a
  (0..8).to_a.inject([]) do |memo, i|
    first_box_index = i / 3 * 3
    three_boxes = boxes[first_box_index, 3]
    three_rows_of_three = three_boxes.map do |box|
      row_number_in_a_box = i % 3
      first_cell_in_the_row_index = row_number_in_a_box * 3
      box[first_cell_in_the_row_index, 3]
    end
    memo + three_rows_of_three.flatten
  end
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    flash.now[:notice] = "Incorrect values are highlighted in red"
  end
  session[:check_solution] = nil
end

def generate_new_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = session[:puzzle]
end

get '/' do
  session[:current_solution] = nil if params[:new]
  session[:current_solution] = session[:puzzle] if params[:update]
  @difficulty = params[:new]
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  erb :index
end

post '/' do
  cells = box_order_to_row_order(params[:cell])
  session[:current_solution] = cells.map { |value| value.to_i }.join
  if params[:save]
    flash[:notice] = "Solution saved"
  else
    session[:check_solution] = true
  end
  redirect to('/')
end

get '/solution' do
  if !session[:solution]
    flash[:notice] = "Start a puzzle before you view a solution"
    redirect to('/')
  else
    @current_solution = session[:solution]
    @solution = session[:solution]
    @puzzle = session[:puzzle]
    erb :solution
  end
end