using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MySql.Data.MySqlClient;
using System.Security.Claims;

namespace pdftest.Pages
{
    [Authorize]
    [IgnoreAntiforgeryToken]
    public class TestModel : PageModel
    {
        public FileResult OnPostSendQuestions(int[] questionIds, string ticket, string school, string speciality)
        {
            string ticketDescription = DbOperations.GetTicketDescription(DbOperations.GetSpecialityId(speciality), int.Parse(ticket)); 
            Console.WriteLine(ticketDescription);
            questionIds = questionIds.Where(x => x != 0).ToArray();
            //byte[] pdfBytes = PdfOperatons.CreateDocument(questionIds, ticket, school, speciality, ticketDescription);
            byte[] pdfBytes = MigraGenerate.Generate(questionIds, ticket, school, speciality, ticketDescription);
            return File(pdfBytes, "application/pdf", "PDFTest.pdf");
        }
    }
}
