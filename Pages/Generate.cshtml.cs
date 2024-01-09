using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace pdftest.Pages
{
    [Authorize]
    public class GenerateModel : PageModel
    {
        public void OnGet()
        {

        }
    }
}
