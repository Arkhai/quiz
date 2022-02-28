# Quiz
## Description

Quiz is written on Ruby and can be launched in the terminal. 

Being launched program takes questions from an xml file (data/q_and_a.xml), shuffle them and shows on the screen with a few answers.

One need to answer each question in the alloted time, which is specified near each question. If alloted time exceeded, quiz would be finished beforehand. 

Each question has specific quantity of points, which one can get by correctly answering the question.

After answering all questions in the alloted time, one can see how many correct answers were given and how many points were received.


## How to change questions and answers

Questions, answers and also points and time for each question are stored in data/q_and_a.xml file. You can change existing and add more questions by editing this file.


## How to launch the quiz
Download the repository to your computer.

Install bundle with command:

```
bundle install
```
Being in the main quiz folder run quiz with command:
```
bundle exec ruby main.rb
```