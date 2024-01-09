using PdfSharp;
using PdfSharp.Drawing;
using PdfSharp.Drawing.Layout;
using PdfSharp.Fonts;
using PdfSharp.Pdf;

namespace pdftest.Pages
{
    public static class PdfOperatons
    {
        public static byte[] CreateDocument(int[] questionsIds, string ticket, string school, string speciality, string ticketDescription)
        {
            PdfDocument document = new PdfDocument();
            PdfPage page = document.AddPage();
            XGraphics gfx = XGraphics.FromPdfPage(page);
            XTextFormatter xf = new XTextFormatter(gfx);
            XFont boldTitleFont = new XFont("Times New Roman", 18, XFontStyleEx.Bold);
            XFont titleFont = new XFont("Times New Roman", 16);
            XFont smallFont = new XFont("Times New Roman", 14);
            XFont boldSmallFont = new XFont("Times New Roman", 14, XFontStyleEx.Bold);

            // gfx.DrawRectangle(XBrushes.Black, new XRect(0,0,600, 850));

            int pageNum = 1;
            gfx.DrawString($"{school}", boldTitleFont, XBrushes.Black, new XRect(0, 40, page.Width, page.Height), XStringFormat.TopCenter);
            document.Info.Title = $"Изпитен билет {ticket}";
            gfx.DrawString($"Изпитен тема №{ticket}: {ticketDescription}", titleFont, XBrushes.Black, new XRect(0, 65, page.Width, page.Height), XStringFormat.TopCenter);
            gfx.DrawString($"Специалност: {speciality}", titleFont, XBrushes.Black, new XRect(0, 90, page.Width, page.Height), XStringFormat.TopCenter);
            gfx.DrawString($"{pageNum}", boldSmallFont, XBrushes.Black, new XPoint(page.Width - 20, page.Height - 20));
            int pos = 1;

            for (int i = 1; i <= questionsIds.Length; i++)
            {
                XRect xRect = new XRect(65, ((150*pos)-12), page.Width-120, 150);
                Questions question = DbOperations.GetQuestionById(questionsIds[i-1]);
                gfx.DrawString($"{i}.", boldSmallFont, XBrushes.Black, new XPoint(50, 150 * pos));
                xf.DrawString($"{question.QuestionText}", boldSmallFont, XBrushes.Black, xRect);
                gfx.DrawString($"{question.Points}т.", smallFont, XBrushes.Black, new XPoint(page.Width-50, 150 * pos));
                if(question.AnswerA != null)
                {
                    xf.DrawString($"А) {question.AnswerA}\nБ) {question.AnswerB}\nВ) {question.AnswerC}\nГ) {question.AnswerD}", smallFont, XBrushes.Black, new XRect(65, (150 * pos) + 15, page.Width - 120, 130), XStringFormat.TopLeft); 
                }
                pos++;
                if(i % 4 == 0)
                {
                    gfx = XGraphics.FromPdfPage(document.AddPage());
                    xf = new XTextFormatter(gfx);
                    pageNum++;
                    pos = 1;
                    gfx.DrawString($"{pageNum}", boldSmallFont, XBrushes.Black, new XPoint(page.Width - 20, page.Height - 20));
                }
            }

            using(MemoryStream stream = new MemoryStream())
            {
                document.Save(stream);
                return stream.ToArray();
            }
            //document.Save("D:\\12b\\mihail 18\\SGIB\\PdfFiles\\test.pdf");
            //document.Save("D:\\VS Programs\\SGIB\\PdfFiles\\test.pdf");
        }
    }
}
