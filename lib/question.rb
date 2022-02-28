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
      #{@text} (баллов: #{@points})
      У вас #{@time} секунд на ответ.
    TEXT
  end

  def show_answers
    @answers.shuffle!
  end

  def correctly_answered?(user_answer)
    @right_answer == @answers[user_answer - 1] if (1..@answers.size).include? (user_answer)
  end
end
