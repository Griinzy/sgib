﻿namespace pdftest.Pages
{
    public class Questions
    {
        public int Id { get; set; }
        public int Ticket { get; set; }
        public string QuestionCategory { get; set; }
        public int QuestionVar { get; set; }
        public string QuestionText { get; set; }
        public string AnswerA { get; set; }
        public string AnswerB { get; set; }
        public string AnswerC { get; set; }
        public string AnswerD { get; set; }
        public int Points { get; set; }
        public string CorrectAnswers { get; set; }
    }
}
