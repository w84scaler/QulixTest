using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using WebTest.Interfaces;
using WebTest.Models;

namespace WebTest.Services
{
    public class CompanyService : ICompanyService
    {
        private string connectionString;
        private SqlDataAdapter dataAdapter;

        public CompanyService(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString(Constants.ConnectionName);
        }

        public IList<Company> GetList()
        {
            IList<Company> list = new List<Company>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("CompanyList", connection);
                command.CommandType = CommandType.StoredProcedure;
                dataAdapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                    {
                        Company company = new Company();
                        FillInstance(company, dataSet.Tables[0].Rows[i]);
                        company.State = Convert.ToInt32(dataSet.Tables[0].Rows[i]["State"]);
                        list.Add(company);
                    }
                }
            }
            return list;
        }

        public void Insert(Company company)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("InsertCompany", connection);
                command.CommandType = CommandType.StoredProcedure;
                FillParameters(command.Parameters, company);
                command.ExecuteNonQuery();
            }
        }

        public Company GetById(int id)
        {
            Company company = new Company();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("GetCompany", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);
                dataAdapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    FillInstance(company, dataSet.Tables[0].Rows[0]);
                }
            }
            return company;
        }

        public void Edit(Company company)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("EditCompany", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", company.Id);
                FillParameters(command.Parameters, company);
                command.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("DeleteCompany", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);
                command.ExecuteNonQuery();
            }
        }

        private void FillParameters(SqlParameterCollection parameters, Company сompany)
        {
            parameters.AddWithValue("@Name", сompany.Name);
            parameters.AddWithValue("@Type", сompany.Type);
        }

        private void FillInstance(Company сompany, DataRow row)
        {
            сompany.Id = Convert.ToInt32(row["Id"]);
            сompany.Name = Convert.ToString(row["Name"]);
            сompany.Type = Convert.ToString(row["Type"]);
        }
    }
}
