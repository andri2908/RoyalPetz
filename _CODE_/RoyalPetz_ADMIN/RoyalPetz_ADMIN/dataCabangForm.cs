﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace RoyalPetz_ADMIN
{
    public partial class dataCabangForm : Form
    {
        private int selectedBranchID;

        private Data_Access DS = new Data_Access();

        public dataCabangForm()
        {
            InitializeComponent();
        }

        private void newButton_Click(object sender, EventArgs e)
        {
            dataCabangDetailForm displayedForm = new dataCabangDetailForm(globalConstants.NEW_BRANCH, 0);
            displayedForm.ShowDialog(this);
        }

        private void loadBranchData(string branchName)
        {
            MySqlDataReader rdr;
            DataTable dt = new DataTable();
            string sqlCommand;

            DS.mySqlConnect();

            sqlCommand = "SELECT BRANCH_ID, BRANCH_NAME AS 'NAMA CABANG', CONCAT(trim(substring(branch_ip4,1,3)),'.',trim(substring(branch_ip4,4,3)),'.',trim(substring(branch_ip4,7,3)),'.', trim(substring(branch_ip4,10))) AS 'ALAMAT IP CABANG' FROM MASTER_BRANCH WHERE BRANCH_ACTIVE = 1 AND BRANCH_NAME LIKE '%"+branchName+"%'";
            //sqlCommand = "SELECT BRANCH_ID, BRANCH_NAME AS 'NAMA CABANG' FROM MASTER_BRANCH WHERE BRANCH_ACTIVE = 1 AND BRANCH_NAME LIKE '%" + branchName + "%'";

            using (rdr = DS.getData(sqlCommand))
            {
                if (rdr.HasRows)
                {
                    dt.Load(rdr);
                    dataCabangGridView.DataSource = dt;

                    dataCabangGridView.Columns["BRANCH_ID"].Visible = false;
                    dataCabangGridView.Columns["NAMA CABANG"].Width = 200;
                    dataCabangGridView.Columns["ALAMAT IP CABANG"].Width = 200;
                }
            }
        }

        private void dataCabangForm_Activated(object sender, EventArgs e)
        {
            loadBranchData(namaBranchTextbox.Text);
        }

        private void namaBranchTextbox_TextChanged(object sender, EventArgs e)
        {
            loadBranchData(namaBranchTextbox.Text);
        }

        private void dataCabangGridView_DoubleClick(object sender, EventArgs e)
        {
            int selectedrowindex = dataCabangGridView.SelectedCells[0].RowIndex;

            DataGridViewRow selectedRow = dataCabangGridView.Rows[selectedrowindex];
            selectedBranchID = Convert.ToInt32(selectedRow.Cells["BRANCH_ID"].Value);

            dataCabangDetailForm displayedForm = new dataCabangDetailForm(globalConstants.EDIT_BRANCH, selectedBranchID);
            displayedForm.ShowDialog(this);
        }



    }
}
