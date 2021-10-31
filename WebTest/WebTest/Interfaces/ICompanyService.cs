using System.Collections.Generic;
using WebTest.Models;

namespace WebTest.Interfaces
{
    public interface ICompanyService
    {
        public IList<Company> GetList();
        public void Insert(Company employee);
        public Company GetById(int id);
        public void Edit(Company company);
        public void Delete(int id);
    }
}
