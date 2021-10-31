using System.ComponentModel.DataAnnotations;

namespace WebTest.Models
{
    public class Company
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        public string Type { get; set; }

        public int State { get; set; }
    }
}
