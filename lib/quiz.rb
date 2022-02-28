require 'rexml/document'

class Quiz
  def self.from_file(file_name)
    file = File.new(file_name, 'r:UTF-8')

    questions = []

    REXML::Document.new(file).root.get_elements('question').map do |question|
      text = question.elements['text'].text
      answers = question.get_elements('answers/answer').map(&:text)
      right_answer = question.get_elements('answers/answer').find { |answer| answer.attributes['right'] == 'true' }.text
      points = question.attributes['points'].to_i
      time = question.attributes['time'].to_i

      questions << Question.new(text: text, answers: answers, right_answer: right_answer, points: points, time: time)
    end

    file.close

    questions
  end

  def initialize(questions)
    @questions = questions.shuffle!
    @points = []
  end

  def <<(points)
    @points << points
  end

  def right_answers
    @points.size
  end

  def score
    @points.sum
  end

  def time_expired?(question_time, time_on)
    Time.now.to_i - time_on < question_time
  end
end
