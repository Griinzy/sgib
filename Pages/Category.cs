namespace pdftest.Pages
{
    public class Category
    {
        public string CategoryDescription { get; set; }
        public int Points { get; set; }
        public int CategoryNumber { get; set; }
        public Category(string categoryDescription, int points, int categoryNumber)
        {
            categoryDescription = CategoryDescription;
            points = Points;
            categoryNumber = CategoryNumber;
        }
        public Category()
        {
                
        }
    }
}
