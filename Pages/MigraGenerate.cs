using Microsoft.AspNetCore.Mvc.RazorPages;
using MigraDoc.DocumentObjectModel;
using MigraDoc.DocumentObjectModel.Visitors;
using MigraDoc.Rendering;
using PdfSharp.Charting;
using PdfSharp.Drawing;
using PdfSharp.Fonts;
using PdfSharp.Pdf;
using System.Drawing;
using System.Reflection.Metadata;

namespace pdftest.Pages
{
    public class MigraGenerate
    {
        public static System.Drawing.Font titleFont = new System.Drawing.Font("Times New Roman", 16);

        public static void SetFontResolver(bool resolved)
        {
            if(!resolved) GlobalFontSettings.FontResolver = new FileFontResolver();
        }

        static bool resolved = false;
        public static byte[] Generate(int[] questionsIds, string ticket, string school, string speciality, string ticketDescription, bool answerList)
        {
            SetFontResolver(resolved);
            resolved = true;

            MigraDoc.DocumentObjectModel.Document doc = new MigraDoc.DocumentObjectModel.Document();
            doc.Info.Title = $"Изпитен билет {ticket}";

            Section section = doc.AddSection();

            Paragraph schoolName = section.AddParagraph();
            schoolName.Format.Alignment = ParagraphAlignment.Center;
            schoolName.Format.Font.Name = "Times New Roman";
            schoolName.Format.Font.Size = 18;
            schoolName.Format.Font.Bold = true;
            schoolName.AddFormattedText($"{school}");

            Paragraph ticketText = section.AddParagraph();
            ticketText.Format.Alignment = ParagraphAlignment.Center;
            ticketText.Format.Font.Name = "Times New Roman";
            ticketText.Format.Font.Size = 16;
            ticketText.AddFormattedText($"Изпитен тема №{ticket}: {ticketDescription}");

            Paragraph specialityText = section.AddParagraph();
            specialityText.Format.Alignment = ParagraphAlignment.Center;
            specialityText.Format.Font.Name = "Times New Roman";
            specialityText.Format.Font.Size = 16;
            specialityText.AddFormattedText($"Специалност: {speciality}");

            for(int i = 1; i <= questionsIds.Length; i++)
            {
                Paragraph questionText = section.AddParagraph();
                questionText.Format.Alignment = ParagraphAlignment.Left;
                questionText.Format.Font.Name = "Times New Roman";
                questionText.Format.Font.Size = 16;
                Questions question = DbOperations.GetQuestionById(questionsIds[i - 1]);
                questionText.AddFormattedText($"{i}. {question.QuestionText}");

                Paragraph points = section.AddParagraph();
                points.Format.Alignment = ParagraphAlignment.Right;
                points.Format.Font.Name = "Times New Roman";
                points.Format.Font.Size = 15;
                points.AddFormattedText($"{question.Points} т.");

                if(question.AnswerA != null)
                {
                    questionText.AddFormattedText($"А) {question.AnswerA}\nБ) {question.AnswerB}\nВ) {question.AnswerC}\nГ) {question.AnswerD}\n");
                }
            }

            if(answerList == true)
            {
                Section answerSection = doc.AddSection();

                Paragraph answersSchoolName = answerSection.AddParagraph();
                answersSchoolName.Format.Alignment = ParagraphAlignment.Center;
                answersSchoolName.Format.Font.Name = "Times New Roman";
                answersSchoolName.Format.Font.Size = 18;
                answersSchoolName.Format.Font.Bold = true;
                answersSchoolName.AddFormattedText($"{school}");

                Paragraph answerTicketText = answerSection.AddParagraph();
                answerTicketText.Format.Alignment = ParagraphAlignment.Center;
                answerTicketText.Format.Font.Name = "Times New Roman";
                answerTicketText.Format.Font.Size = 16;
                answerTicketText.AddFormattedText($"Изпитен тема №{ticket}: {ticketDescription}");

                Paragraph answerSpecialityText = answerSection.AddParagraph();
                answerSpecialityText.Format.Alignment = ParagraphAlignment.Center;
                answerSpecialityText.Format.Font.Name = "Times New Roman";
                answerSpecialityText.Format.Font.Size = 16;
                answerSpecialityText.AddFormattedText($"Специалност: {speciality}");
            }

            PdfDocumentRenderer renderer = new PdfDocumentRenderer();
            renderer.Document = doc;
            renderer.RenderDocument();

            using(MemoryStream stream = new MemoryStream())
            {
                renderer.PdfDocument.Save(stream);
                return stream.ToArray();
            }
        }
    }

    public class FileFontResolver : IFontResolver // FontResolverBase
    {
        public string DefaultFontName => throw new NotImplementedException();

        public byte[] GetFont(string faceName)
        {
            using (var ms = new MemoryStream())
            {
                using (var fs = File.Open(faceName, FileMode.Open))
                {
                    fs.CopyTo(ms);
                    ms.Position = 0;
                    return ms.ToArray();
                }
            }
        }

        public FontResolverInfo ResolveTypeface(string familyName, bool isBold, bool isItalic)
        {
            if (familyName.Equals("Times New Roman", StringComparison.CurrentCultureIgnoreCase))
            {
                if (isBold && isItalic)
                {
                    return new FontResolverInfo("Fonts/timesbi.ttf");
                }
                else if (isBold)
                {
                    return new FontResolverInfo("Fonts/timesbd.ttf");
                }
                else if (isItalic)
                {
                    return new FontResolverInfo("Fonts/timesi.ttf");
                }
                else
                {
                    return new FontResolverInfo("Fonts/times.ttf");
                }
            }
            return null;
        }
    }
}
