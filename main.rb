# Код, чтобы не заморачиваться с кодировкой в Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

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
  Проверьте свои знания с помощью викторины. Ответьте на #{questions.size} вопросов.
  Около каждого вопроса вы увидите количество баллов за правильный ответ, а также отведенное на ответ время.
  Если вы не уложитесь в обозначенное время, викторина завершится.

DESC

questions.each.with_index(1) do |question, index|
  puts "#{index}. #{question.show}".colorize(:magenta)
  time_on = Time.now.to_i
  question.show_answers.each.with_index(1) { |answer, index| puts "#{index}. #{answer}".colorize(:cyan) }
  user_answer = STDIN.gets.to_i
  quiz << question.points if question.correctly_answered?(user_answer)

  unless quiz.time_expired?(question.time, time_on)
    puts <<~ERROR
      Время на ответ превысило допустимый промежуток!
      Викторина будет прервана.
    ERROR
    break
  end
end

puts <<~FINALTEXT
  Правильных ответов #{quiz.right_answers} из #{questions.size}.
  Вы набрали #{quiz.score} баллов.
FINALTEXT
