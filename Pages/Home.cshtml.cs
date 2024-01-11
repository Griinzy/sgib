using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MySql.Data.MySqlClient;
using System.Security.Claims;

namespace pdftest.Pages
{
    [Authorize]
    public class HomeModel : PageModel
    {
        
        public void OnGet()
        {
            // Console.WriteLine(User.FindFirstValue("isAdmin"));
        }
        public IActionResult OnPostAdmin()
        {
            return RedirectToPage("Admin");
        }
        public void OnPostUploadQuestion(string speciality, string ticketNumber, string category, string questionPoints,
            string questionText1, string answerA1, string answerB1, string answerC1, string answerD1, 
            string questionText2, string answerA2, string answerB2, string answerC2, string answerD2, 
            bool correctAnswerA1, bool correctAnswerB1, bool correctAnswerC1, bool correctAnswerD1,
            bool correctAnswerA2, bool correctAnswerB2, bool correctAnswerC2, bool correctAnswerD2,
            string openAnswer1, string openAnswer2)
        {
            Console.Write(correctAnswerD2);
            DbOperations.AddNewQuestion(speciality, int.Parse(ticketNumber), category, 
                questionText1, questionText2, 
                answerA1, answerB1, answerC1, answerD1, 
                answerA2, answerB2, answerC2, answerD2, 
                correctAnswerA1, correctAnswerB1, correctAnswerC1, correctAnswerD1,
                correctAnswerA2, correctAnswerB2, correctAnswerC2, correctAnswerD2,
                openAnswer1, openAnswer2,
                int.Parse(questionPoints),

                DbOperations.GetSchoolId(User.FindFirstValue("school")));
        }
    }
}
