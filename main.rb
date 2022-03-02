require 'date'
require 'colorize'
require 'colorized_string'
require_relative 'lib/quiz'
require_relative 'lib/question'

current_path = File.dirname(__FILE__)

file_name = current_path + '/data/q_and_a.xml'

questions = Quiz.from_file(file_name)
quiz = Quiz.new(questions)

puts <<~DESC
  You can check your knowledge with this quiz. It contains #{questions.size} questions.
  Points for correct answer and alloted time to answer are nearby each question.
  If you exceed alloted time for the answer, the quiz would be finished beforehand.

DESC

questions.each.with_index(1) do |question, index|
  puts "#{index}. #{question.show}".colorize(:magenta)
  time_on = Time.now.to_i
  question.show_answers.each.with_index(1) { |answer, index| puts "#{index}. #{answer}".colorize(:cyan) }
  user_answer = STDIN.gets.to_i
  quiz << question.points if question.correctly_answered?(user_answer)

  unless quiz.time_expired?(question.time, time_on)
    puts <<~ERROR
      Alloted time for the answer was exceeded.
      Quiz would be interrupted.
    ERROR
    break
  end
end

puts <<~FINALTEXT
  You have got #{quiz.right_answers} correct answers out of #{questions.size} questions.
  You have got #{quiz.score} points.
FINALTEXT
