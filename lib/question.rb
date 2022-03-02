class Question
  attr_reader :points, :time

  def initialize(text:, answers:, right_answer:, points:, time:)
    @text = text
    @answers = answers
    @right_answer = right_answer
    @points = points
    @time = time
  end

  def show
    <<~TEXT
      #{@text} (#{@points} points)
      You have #{@time} seconds to answer.
    TEXT
  end

  def show_answers
    @answers.shuffle!
  end

  def correctly_answered?(user_answer)
    @right_answer == @answers[user_answer - 1] if (1..@answers.size).include? (user_answer)
  end
end
