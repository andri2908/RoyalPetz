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
using System.Globalization;

using System.Text.RegularExpressions;
using Hotkeys;

namespace AlphaSoft
{
    public partial class dataProdukDetailForm : Form
    {
        private Data_Access DS = new Data_Access();
        private globalUtilities gUtil = new globalUtilities();

        private int originModuleID = 0;
        private int selectedInternalProductID = 0;
        private int selectedProductExpiryID = 0;
        private string selectedKodeProduk = "";
        private double selectedProductOriginalQty = 0;
        private double selectedProductOriginalTotalQty = 0;

        private string productID = "";
        private int selectedUnitID;
        private string photoFileName = "";
        private List<int> currentSelectedKategoriID = new List<int>();
        
        private string stokAwalText = "";
        private string limitStokText = "";
        private string hppValueText = "";
        private string hargaEcerValueText = "";
        private string hargaPartaiText = "";
        private string hargaGrosirValueText = "";
        private string selectedPhoto = "";
        private int options = 0;
        private bool isLoading = false;
        private stokPecahBarangForm parentForm;

        dataKategoriProdukForm selectKategoriForm = null;
        SupplierHistoryForm HistoryForm = null;
        dataSatuanForm selectSatuanForm = null;

        private Hotkeys.GlobalHotkey ghk_UP;
        private Hotkeys.GlobalHotkey ghk_DOWN;
        private Hotkeys.GlobalHotkey ghk_DEL;

        private bool navKeyRegistered = false;
        private bool delKeyRegistered = false;

        private CultureInfo culture = new CultureInfo("id-ID");

        DateTimePicker oDateTimePicker = new DateTimePicker();

        public dataProdukDetailForm()
        {
            InitializeComponent();
        }

        public dataProdukDetailForm(int moduleID)
        {
            InitializeComponent();

            originModuleID = moduleID;
        }

        public dataProdukDetailForm(int moduleID, stokPecahBarangForm thisParentForm)
        {
            InitializeComponent();

            originModuleID = moduleID;
            parentForm = thisParentForm;
        }

        private void captureAll(Keys key)
        {
            switch (key)
            {
                case Keys.Up:
                    SendKeys.Send("+{TAB}");
                    break;
                case Keys.Down:
                    SendKeys.Send("{TAB}");
                    break;
                case Keys.Delete:
                    if (DialogResult.Yes == MessageBox.Show("HAPUS BARIS YG DIPILIH?", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation))
                        deleteCurrentRow();
                    break;
            }
        }

        protected override void WndProc(ref Message m)
        {
            if (m.Msg == Constants.WM_HOTKEY_MSG_ID)
            {
                Keys key = (Keys)(((int)m.LParam >> 16) & 0xFFFF);
                int modifier = (int)m.LParam & 0xFFFF;

                if (modifier == Constants.NOMOD)
                    captureAll(key);
            }

            base.WndProc(ref m);
        }

        private void registerGlobalHotkey()
        {
            ghk_UP = new Hotkeys.GlobalHotkey(Constants.NOMOD, Keys.Up, this);
            ghk_UP.Register();

            ghk_DOWN = new Hotkeys.GlobalHotkey(Constants.NOMOD, Keys.Down, this);
            ghk_DOWN.Register();

            navKeyRegistered = true;
        }

        private void unregisterGlobalHotkey()
        {
            if (!navKeyRegistered)
                return;

            ghk_UP.Unregister();
            ghk_DOWN.Unregister();

            navKeyRegistered = false;
        }

        private void registerDelKey()
        {
            return;

            ghk_DEL = new Hotkeys.GlobalHotkey(Constants.NOMOD, Keys.Delete, this);
            ghk_DEL.Register();

            delKeyRegistered = true;
        }

        private void unregisterDelKey()
        {
            return;

            ghk_DEL.Unregister();

            delKeyRegistered = false;
        }

        public void deleteCurrentRow()
        {
            if (expDataGridView.Rows.Count > 1)
            {
                int rowSelectedIndex = expDataGridView.SelectedCells[0].RowIndex;
                DataGridViewRow selectedRow = expDataGridView.Rows[rowSelectedIndex];
                expDataGridView.CurrentCell = selectedRow.Cells["qty"];
                string lotIDValue = "";

                if (null != selectedRow && rowSelectedIndex != expDataGridView.Rows.Count - 1)
                {
                    isLoading = true;
                    if (selectedRow.Index >= 0)
                    {
                        if (null != expDataGridView.Rows[rowSelectedIndex].Cells["lotID"].Value)
                            lotIDValue = expDataGridView.Rows[rowSelectedIndex].Cells["lotID"].Value.ToString();
                        else
                            lotIDValue = "0";

                        expDataGridView.Rows.Remove(expDataGridView.Rows[rowSelectedIndex]);
                        expDataGridView.AllowUserToAddRows = true;

                        if (lotIDValue != "0")
                            expDataGridViewHidden.Rows.Add(lotIDValue);

                        gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "deleteCurrentRow [" + rowSelectedIndex + "]");
                        calculateTotalQty();
                    }
                    isLoading = false;
                }
            }
        }

        private void deleteAllRow()
        {
            if (expDataGridView.Rows.Count > 1)
            {
                for (int i =0;i<expDataGridView.Rows.Count-1;i++)
                {
                    int rowSelectedIndex = i;// expDataGridView.SelectedCells[0].RowIndex;
                    DataGridViewRow selectedRow = expDataGridView.Rows[rowSelectedIndex];
                    expDataGridView.CurrentCell = selectedRow.Cells["qty"];
                    string lotIDValue = "";

                    if (null != selectedRow)// && rowSelectedIndex != expDataGridView.Rows.Count-1)
                    {
                        isLoading = true;
                        if (selectedRow.Index >= 0)
                        {
                            if (null != expDataGridView.Rows[rowSelectedIndex].Cells["lotID"].Value)
                                lotIDValue = expDataGridView.Rows[rowSelectedIndex].Cells["lotID"].Value.ToString();
                            else
                                lotIDValue = "0";

                            if (lotIDValue != "0")
                                expDataGridViewHidden.Rows.Add(lotIDValue);

                            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "deleteCurrentRow [" + rowSelectedIndex + "]");
                        }
                        isLoading = false;
                    }
                }

                expDataGridView.Rows.Clear();
            }
        }

        public void setSelectedUnitID(int unitID)
        {
            selectedUnitID = unitID;

            loadUnitIDInformation();
        }

        public void addSelectedKategoriID(int kategoriID, bool immediatelyLoad = true)
        {
            bool exist = false;
            for (int i = 0; ((i<currentSelectedKategoriID.Count) && (exist == false));i++)
            {
                if (currentSelectedKategoriID[i] == kategoriID)
                    exist = true;
            }

            if (!exist)
                currentSelectedKategoriID.Add(kategoriID);

            if (immediatelyLoad == true)
                loadKategoriIDInformation();
        }

        private bool checkRegEx(string textToCheck)
        {
            if (gUtil.matchRegEx(textToCheck, globalUtilities.REGEX_NUMBER_WITH_2_DECIMAL))
                return true;

            return false;            
        }

        public dataProdukDetailForm(int moduleID, int productID)
        {
            string selectedProductID = "";
            InitializeComponent();

            originModuleID = moduleID;

            //if (globalFeatureList.EXPIRY_MODULE == 1)
            //{
            //    selectedProductExpiryID = productID;
            //    selectedProductID = DS.getDataSingleValue("SELECT PRODUCT_ID FROM PRODUCT_EXPIRY WHERE ID = " + productID).ToString();
            //    selectedInternalProductID = Convert.ToInt32(DS.getDataSingleValue("SELECT ID FROM MASTER_PRODUCT WHERE PRODUCT_ID = '" + selectedProductID + "'"));
            //}
            //else
            { 
                selectedInternalProductID = productID;
                selectedKodeProduk = DS.getDataSingleValue("SELECT PRODUCT_ID FROM MASTER_PRODUCT WHERE ID = '" + selectedInternalProductID + "'").ToString();
            }
        }

        private void stokAwalTextBox_TextChanged(object sender, EventArgs e)
        {
            string tempString = "";

            if (isLoading || stokAwalTextBox.ReadOnly == true || stokAwalTextBox.Enabled == false)
                return;
            
            isLoading = true;
            if (stokAwalTextBox.Text.Length == 0)
            {
                // IF TEXTBOX IS EMPTY, SET THE VALUE TO 0 AND EXIT THE CHECKING
                stokAwalText = "0";
                stokAwalTextBox.Text = "0";

                stokAwalTextBox.SelectionStart = stokAwalTextBox.Text.Length;
                isLoading = false;

                return;
            }
            // CHECKING TO PREVENT PREFIX "0" IN A NUMERIC INPUT WHILE ALLOWING A DECIMAL VALUE STARTED WITH "0"
            else if (stokAwalTextBox.Text.IndexOf('0') == 0 && stokAwalTextBox.Text.Length > 1 && stokAwalTextBox.Text.IndexOf("0.") < 0 )
            {
                tempString = stokAwalTextBox.Text;
                stokAwalTextBox.Text = tempString.Remove(0, 1);
            }

            if (checkRegEx(stokAwalTextBox.Text))
                stokAwalText = stokAwalTextBox.Text;
            else
                stokAwalTextBox.Text = stokAwalText;

            stokAwalTextBox.SelectionStart = stokAwalTextBox.Text.Length;

            isLoading = false;
        }

        private void limitStokTextBox_TextChanged(object sender, EventArgs e)
        {
            string tempString;

            if (isLoading)
                return;

            isLoading = true;
            if (limitStokTextBox.Text.Length == 0)
            {
                // IF TEXTBOX IS EMPTY, SET THE VALUE TO 0 AND EXIT THE CHECKING
                limitStokText = "0";
                limitStokTextBox.Text = "0";

                limitStokTextBox.SelectionStart = limitStokTextBox.Text.Length;

                isLoading = false;

                return;
            }
            // CHECKING TO PREVENT PREFIX "0" IN A NUMERIC INPUT WHILE ALLOWING A DECIMAL VALUE STARTED WITH "0"
            else if (limitStokTextBox.Text.IndexOf('0') == 0 && limitStokTextBox.Text.Length > 1 && limitStokTextBox.Text.IndexOf("0.") < 0)
            {
                tempString = limitStokTextBox.Text;
                limitStokTextBox.Text = tempString.Remove(0, 1);
            }

            if (checkRegEx(limitStokTextBox.Text))
                limitStokText = limitStokTextBox.Text;
            else
                limitStokTextBox.Text = limitStokText;

            limitStokTextBox.SelectionStart = limitStokTextBox.Text.Length;

            isLoading = false;
        }

        private void hppTextBox_TextChanged(object sender, EventArgs e)
        {
            string tempString;

            if (isLoading)
                return;

            isLoading = true;
            if (hppTextBox.Text.Length == 0)
            {
                // IF TEXTBOX IS EMPTY, SET THE VALUE TO 0 AND EXIT THE CHECKING
                hppValueText = "0";
                hppTextBox.Text = "0";

                hppTextBox.SelectionStart = hppTextBox.Text.Length;
                isLoading = false;

                return;
            }
            // CHECKING TO PREVENT PREFIX "0" IN A NUMERIC INPUT WHILE ALLOWING A DECIMAL VALUE STARTED WITH "0"
            else if (hppTextBox.Text.IndexOf('0') == 0 && hppTextBox.Text.Length > 1 && hppTextBox.Text.IndexOf("0.") < 0)
            {
                tempString = hppTextBox.Text;
                hppTextBox.Text = tempString.Remove(0, 1);
            }

            if (checkRegEx(hppTextBox.Text))
                hppValueText = hppTextBox.Text;
            else
                hppTextBox.Text = hppValueText;

            hppTextBox.SelectionStart = hppTextBox.Text.Length;
            isLoading = false;
        }

        private double calculateMargin(string baseValue, string newValue)
        {
            double result = 0;
            double basePrice = 0;
            double salesPrice = 0;
            double difference = 0;

            if ((baseValue.Length > 0) && (newValue.Length > 0))
            {
                basePrice = Convert.ToDouble(baseValue);
                salesPrice = Convert.ToDouble(newValue);

                difference = salesPrice - basePrice;
                result = Math.Round(difference / basePrice * 100, 2);
            }

            return result;
        }

        private void hargaEcerTextBox_TextChanged(object sender, EventArgs e)
        {
            string tempString;

            if (isLoading)
                return;

            isLoading = true;
            if (hargaEcerTextBox.Text.Length == 0)
            {
                // IF TEXTBOX IS EMPTY, SET THE VALUE TO 0 AND EXIT THE CHECKING
                hargaEcerValueText = "0";
                hargaEcerTextBox.Text = "0";

                hargaEcerTextBox.SelectionStart = hargaEcerTextBox.Text.Length;
                isLoading = false;

                return;
            }
            // CHECKING TO PREVENT PREFIX "0" IN A NUMERIC INPUT WHILE ALLOWING A DECIMAL VALUE STARTED WITH "0"
            else if (hargaEcerTextBox.Text.IndexOf('0') == 0 && hargaEcerTextBox.Text.Length > 1 && hargaEcerTextBox.Text.IndexOf("0.") < 0)
            {
                tempString = hargaEcerTextBox.Text;
                hargaEcerTextBox.Text = tempString.Remove(0, 1);
            }

            if (checkRegEx(hargaEcerTextBox.Text))
                hargaEcerValueText = hargaEcerTextBox.Text;
            else
                hargaEcerTextBox.Text = hargaEcerValueText;

            hargaEcerTextBox.SelectionStart = hargaEcerTextBox.Text.Length;

            ecerMargin.Text = calculateMargin(hppTextBox.Text, hargaEcerTextBox.Text).ToString() + "%";

            isLoading = false;
        }

        private void hargaPartaiTextBox_TextChanged(object sender, EventArgs e)
        {
            string tempString;

            if (isLoading)
                return;

            isLoading = true;
            if (hargaPartaiTextBox.Text.Length == 0)
            {
                // IF TEXTBOX IS EMPTY, SET THE VALUE TO 0 AND EXIT THE CHECKING
                hargaPartaiText = "0";
                hargaPartaiTextBox.Text = "0";

                hargaPartaiTextBox.SelectionStart = hargaPartaiTextBox.Text.Length;
                isLoading = false;

                return;
            }
            // CHECKING TO PREVENT PREFIX "0" IN A NUMERIC INPUT WHILE ALLOWING A DECIMAL VALUE STARTED WITH "0"
            else if (hargaPartaiTextBox.Text.IndexOf('0') == 0 && hargaPartaiTextBox.Text.Length > 1 && hargaPartaiTextBox.Text.IndexOf("0.") < 0)
            {
                tempString = hargaPartaiTextBox.Text;
                hargaPartaiTextBox.Text = tempString.Remove(0, 1);
            }

            if (checkRegEx(hargaPartaiTextBox.Text))
                hargaPartaiText = hargaPartaiTextBox.Text;
            else
                hargaPartaiTextBox.Text = hargaPartaiText;

            hargaPartaiTextBox.SelectionStart = hargaPartaiTextBox.Text.Length;

            partaiMargin.Text = calculateMargin(hppTextBox.Text, hargaPartaiTextBox.Text).ToString() + "%";

            isLoading = false;
        }

        private void hargaGrosirTextBox_TextChanged(object sender, EventArgs e)
        {
            string tempString;

            if (isLoading)
                return;

            isLoading = true;
            if (hargaGrosirTextBox.Text.Length == 0)
            {
                // IF TEXTBOX IS EMPTY, SET THE VALUE TO 0 AND EXIT THE CHECKING
                hargaGrosirValueText = "0";
                hargaGrosirTextBox.Text = "0";

                hargaGrosirTextBox.SelectionStart = hargaGrosirTextBox.Text.Length;
                isLoading = false;

                return;
            }
            // CHECKING TO PREVENT PREFIX "0" IN A NUMERIC INPUT WHILE ALLOWING A DECIMAL VALUE STARTED WITH "0"
            else if (hargaGrosirTextBox.Text.IndexOf('0') == 0 && hargaGrosirTextBox.Text.Length > 1 && hargaGrosirTextBox.Text.IndexOf("0.") < 0)
            {
                tempString = hargaGrosirTextBox.Text;
                hargaGrosirTextBox.Text = tempString.Remove(0, 1);
            }

            if (checkRegEx(hargaGrosirTextBox.Text))
                hargaGrosirValueText = hargaGrosirTextBox.Text;
            else
                hargaGrosirTextBox.Text = hargaGrosirValueText;

            hargaGrosirTextBox.SelectionStart = hargaGrosirTextBox.Text.Length;
            grosirMargin.Text = calculateMargin(hppTextBox.Text, hargaGrosirTextBox.Text).ToString() + "%";

            isLoading = false;
        }

        private void loadProdukData()
        {
            MySqlDataReader rdr;
            DataTable dt = new DataTable();
            string productShelves = "";
            string fileName = "";
            double productExpiryAmount = 0;

            DS.mySqlConnect();

            //if (globalFeatureList.EXPIRY_MODULE == 1)
            //{
            //    if (selectedProductExpiryID > 0)
            //    {
            //        productExpiryAmount = Convert.ToDouble(DS.getDataSingleValue("SELECT PRODUCT_AMOUNT FROM PRODUCT_EXPIRY WHERE ID = " + selectedProductExpiryID));
            //        expDatePicker.Value = Convert.ToDateTime(DS.getDataSingleValue("SELECT PRODUCT_EXPIRY_DATE FROM PRODUCT_EXPIRY WHERE ID = " + selectedProductExpiryID));
            //    }
            //}
            
            // LOAD PRODUCT DATA
            using (rdr = DS.getData("SELECT * FROM MASTER_PRODUCT WHERE ID =  " + selectedInternalProductID))
            {
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        kodeProdukTextBox.Text = rdr.GetString("PRODUCT_ID");
                        barcodeTextBox.Text = rdr.GetString("PRODUCT_BARCODE");
                        namaProdukTextBox.Text = rdr.GetString("PRODUCT_NAME");
                        produkDescTextBox.Text = rdr.GetString("PRODUCT_DESCRIPTION");
                        hppTextBox.Text = rdr.GetString("PRODUCT_BASE_PRICE");
                        hargaEcerTextBox.Text = rdr.GetString("PRODUCT_RETAIL_PRICE");
                        hargaPartaiTextBox.Text = rdr.GetString("PRODUCT_BULK_PRICE");
                        hargaGrosirTextBox.Text = rdr.GetString("PRODUCT_WHOLESALE_PRICE"); 
                        SupplierTextBox.Text = rdr.GetString("PRODUCT_BRAND");

                        ecerMargin.Text = calculateMargin(hppTextBox.Text, hargaEcerTextBox.Text).ToString() + "%";
                        partaiMargin.Text = calculateMargin(hppTextBox.Text, hargaPartaiTextBox.Text).ToString() + "%";
                        grosirMargin.Text = calculateMargin(hppTextBox.Text, hargaGrosirTextBox.Text).ToString() + "%";


                        if (globalFeatureList.EXPIRY_MODULE == 1)
                        {
                            if (rdr.GetString("PRODUCT_EXPIRABLE").Equals("1"))
                            {
                                expiredCheckBox.Checked = true;
                                stokAwalTextBox.Enabled = false;
                                expDataGridView.ReadOnly = false;
                                expDataGridView.Enabled = true;
                            }
                            else
                            {
                                expiredCheckBox.Checked = false;
                                stokAwalTextBox.Enabled = true;
                                expDataGridView.ReadOnly = true;
                                expDataGridView.Enabled = false;
                            }
                        }

                        stokAwalTextBox.Text = rdr.GetString("PRODUCT_STOCK_QTY");
                        limitStokTextBox.Text = rdr.GetString("PRODUCT_LIMIT_STOCK");

                        productShelves = rdr.GetString("PRODUCT_SHELVES");

                        noRakBarisTextBox.Text = productShelves.Substring(0, 2);
                        noRakKolomTextBox.Text = productShelves.Substring(2); 

                        selectedUnitID = rdr.GetInt32("UNIT_ID");
                        if (rdr.GetString("PRODUCT_ACTIVE").Equals("1"))
                            nonAktifCheckbox.Checked = false;
                        else
                            nonAktifCheckbox.Checked = true;
                        
                        if (rdr.GetString("PRODUCT_IS_SERVICE").Equals("1"))
                        { 
                            produkJasaCheckbox.Checked = true;
                            stokAwalTextBox.Enabled = false;
                            limitStokTextBox.Enabled = false;
                        }
                        else
                        { 
                            produkJasaCheckbox.Checked = false;
                            stokAwalTextBox.Enabled = true;
                            limitStokTextBox.Enabled = true;
                        }

                        fileName = rdr.GetString("PRODUCT_PHOTO_1").Trim();

                        if (!fileName.Equals(""))
                        {
                            try
                            {
                                panelImage.BackgroundImageLayout = ImageLayout.Stretch;
                                panelImage.BackgroundImage = Image.FromFile("PRODUCT_PHOTO/" + fileName);

                                selectedPhoto = "PRODUCT_PHOTO/" + fileName;
                                photoFileName = fileName;
                            }
                            catch (Exception ex)
                            {
                            }
                        }
                    }
                }
            }
        }

        private void loadProdukExpData()
        {
            MySqlDataReader rdr;
            DataTable dt = new DataTable();
            bool checkBoxValue = false;
            DS.mySqlConnect();

            string sqlCommand = "";

            if (showInactiveExpiryCheckBox.Checked)
                sqlCommand = "SELECT * FROM PRODUCT_EXPIRY WHERE PRODUCT_ID =  '" + selectedKodeProduk + "' AND IS_DELETED = 0";
            else
                sqlCommand = "SELECT * FROM PRODUCT_EXPIRY WHERE PRODUCT_ID =  '" + selectedKodeProduk + "' AND IS_DELETED = 0 AND EXPIRY_ACTIVE = 1";

            using (rdr = DS.getData(sqlCommand))
            {
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        expDataGridView.AllowUserToAddRows = true;
                        if (rdr.GetInt32("EXPIRY_ACTIVE") == 1)
                        { 
                            checkBoxValue = true;
                            stokAwalTextBox.Enabled = false;
                        }
                        else
                            checkBoxValue = false;

                        string expDateValue = String.Format(culture, "{0:" + globalUtilities.CUSTOM_DATE_FORMAT + "}", rdr.GetDateTime("PRODUCT_EXPIRY_DATE"));
                        expDataGridView.Rows.Add(rdr.GetString("ID"), checkBoxValue, rdr.GetString("PRODUCT_AMOUNT"), expDateValue, rdr.GetString("PRODUCT_EXPIRY_DATE"));
                    }

                    expDataGridView.AllowUserToAddRows = true;
                    expDataGridView.CurrentCell = expDataGridView.Rows[expDataGridView.Rows.Count - 1].Cells["qty"];
                }
            }
        }

        private void loadProductCategoryData()
        {
            MySqlDataReader rdr;
            DataTable dt = new DataTable();

            if (kodeProdukTextBox.Text.Equals(""))
                return;

            DS.mySqlConnect();

            using (rdr = DS.getData("SELECT * FROM PRODUCT_CATEGORY WHERE PRODUCT_ID =  '" + kodeProdukTextBox.Text +"'"))
            {
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        addSelectedKategoriID(rdr.GetInt32("CATEGORY_ID"), false);
                    }
                }
            }

            rdr.Close();
            loadKategoriIDInformation();
        }

        private void loadUnitIDInformation()
        {
            string sqlCommand;
            string unitName = "";
            DS.mySqlConnect();

            if (selectedUnitID == 0)
                return;

            sqlCommand = "SELECT IFNULL(UNIT_NAME, '') FROM MASTER_UNIT WHERE UNIT_ID = " + selectedUnitID;
            unitName = DS.getDataSingleValue(sqlCommand).ToString();

            unitTextBox.Text = unitName;
        }

        private void loadKategoriIDInformation()
        {
            string sqlCommand;
            string kategoriName = "";

            DS.mySqlConnect();

            produkKategoriTextBox.Text = "";

            for (int i = 0;i<currentSelectedKategoriID.Count;i++)
            {
                sqlCommand = "SELECT IFNULL(CATEGORY_NAME, '') FROM MASTER_CATEGORY WHERE CATEGORY_ID = " + currentSelectedKategoriID[i];

                if (!kategoriName.Equals(""))
                    kategoriName = kategoriName + ", ";

                kategoriName = kategoriName + DS.getDataSingleValue(sqlCommand).ToString();
            }

            produkKategoriTextBox.Text = kategoriName;
        }

        private void clearUpProductCategory()
        {
            produkKategoriTextBox.Clear();
            currentSelectedKategoriID.Clear();
        }

        private void searchUnitButton_Click(object sender, EventArgs e)
        {
            if (null == selectSatuanForm || selectSatuanForm.IsDisposed)
                selectSatuanForm = new dataSatuanForm(globalConstants.PRODUK_DETAIL_FORM, this);

            selectSatuanForm.Show();
            selectSatuanForm.WindowState = FormWindowState.Normal;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string fileName = "";

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    fileName = openFileDialog1.FileName;
                    panelImage.BackgroundImageLayout = ImageLayout.Stretch;
                    panelImage.BackgroundImage = Image.FromFile(fileName);

                    selectedPhoto = openFileDialog1.FileName;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
                }
            }
        }

        private void searchKategoriButton_Click(object sender, EventArgs e)
        {
            if (null == selectKategoriForm || selectKategoriForm.IsDisposed)
            {
                selectKategoriForm = new dataKategoriProdukForm(globalConstants.PRODUK_DETAIL_FORM, this);
            }

            selectKategoriForm.Show();
            selectKategoriForm.WindowState = FormWindowState.Normal;
        }

        private bool dataValidated()
        {
            int i = 0;
            bool dataExist = true;

            if (namaProdukTextBox.Text.Equals(""))
            {
                errorLabel.Text = "NAMA PRODUK TIDAK BOLEH KOSONG";
                return false;
            }

            if (hppTextBox.Text.Length <= 0 || Convert.ToDouble(hppTextBox.Text) == 0)
            {
                errorLabel.Text = "HARGA POKOK TIDAK BOLEH 0 / KOSONG";
                return false;
            }

            if (hargaEcerTextBox.Text.Length <= 0 || Convert.ToDouble(hargaEcerTextBox.Text) == 0)
            {
                errorLabel.Text = "HARGA ECER TIDAK BOLEH 0 / KOSONG";
                return false;
            }

            if (hargaGrosirTextBox.Text.Length <= 0 || Convert.ToDouble(hargaGrosirTextBox.Text) == 0)
            {
                errorLabel.Text = "HARGA PARTAI TIDAK BOLEH 0 / KOSONG";
                return false;
            }

            if (hargaPartaiTextBox.Text.Length <= 0 || Convert.ToDouble(hargaPartaiTextBox.Text) == 0)
            {
                errorLabel.Text = "HARGA GROSIR TIDAK BOLEH 0 / KOSONG";
                return false;
            }

            if (unitTextBox.Text.Equals(""))
            {
                errorLabel.Text = "UNIT TIDAK BOLEH KOSONG";
                return false;
            }

            if (barcodeTextBox.Text.Length > 0 && (barcodeExist()) && (originModuleID == globalConstants.NEW_PRODUK))
            {
                errorLabel.Text = "BARCODE SUDAH ADA";
                return false;
            }

            string kodeProdukValue = MySqlHelper.EscapeString(kodeProdukTextBox.Text);
            if (kodeProdukValue.Length <= 0)
            {
                errorLabel.Text = "PRODUK ID TIDAK BOLEH KOSONG";
                return false;
            }

            if ((productIDExist(kodeProdukValue)) && (originModuleID != globalConstants.EDIT_PRODUK))
            {
                errorLabel.Text = "PRODUK ID SUDAH ADA";
                return false;
            }

            if (globalFeatureList.EXPIRY_MODULE == 1)
            {
                for (i = 0; i < expDataGridView.Rows.Count-1 && dataExist; i++)
                {
                    if (null != expDataGridView.Rows[i].Cells["expiryDateValue"].Value && 
                        expDataGridView.Rows[i].Cells["expiryDateValue"].Value.ToString().Length > 0)
                        dataExist = true;
                    else
                        dataExist = false;

                    if (dataExist)
                    {
                        double tempQtyValue = 0;
                        if (!double.TryParse(expDataGridView.Rows[i].Cells["qty"].Value.ToString(), out tempQtyValue))
                            dataExist = false;
                    }
                }

                if (!dataExist)
                {
                    errorLabel.Text = "INPUT PADA BARIS [" + i + "] SALAH";
                    return false;
                }
            }

            return true;
        }

        private bool saveDataTransaction()
        {
            bool result = false;
            string sqlCommand = "";
            string noRakBaris = "";
            string noRakKolom = "";
            MySqlException internalEX = null;

            productID = MySqlHelper.EscapeString(kodeProdukTextBox.Text);
            string produkBarcode = barcodeTextBox.Text;
            if (produkBarcode.Equals(""))
                produkBarcode = "0";

            string produkName = MySqlHelper.EscapeString(namaProdukTextBox.Text.Trim());

            string produkDesc = produkDescTextBox.Text.Trim();
            if (produkDesc.Equals(""))
                produkDesc = " ";
            else
                produkDesc = MySqlHelper.EscapeString(produkDesc);

            string produkHargaPokok = hppTextBox.Text;
            string produkHargaEcer = hargaEcerTextBox.Text;
            string produkHargaPartai = hargaPartaiTextBox.Text;
            string produkHargaGrosir = hargaGrosirTextBox.Text;

            string produkBrand = SupplierTextBox.Text.Trim();
            if (produkBrand.Equals(""))
                produkBrand = " ";
            else
                produkBrand = MySqlHelper.EscapeString(produkBrand);

            // recalculate the qty again
            if (expiredCheckBox.Checked)
            {
                calculateTotalQty();
            }
            string produkQty = stokAwalTextBox.Text;
            if (produkQty.Equals(""))
                produkQty = "0";

            string limitStock = limitStokTextBox.Text;
            if (limitStock.Equals(""))
                limitStock = "0";

            noRakBaris = MySqlHelper.EscapeString(noRakBarisTextBox.Text);
            noRakKolom= noRakKolomTextBox.Text;
            
            while (noRakBaris.Length < 2)
                noRakBaris = "-" + noRakBaris;

            while (noRakKolom.Length < 2)
                noRakKolom = "0" + noRakKolom;

            string produkShelves = noRakBaris + noRakKolom;

            byte produkSvc = 0;
            if (produkJasaCheckbox.Checked)
                produkSvc = 1;
            else
                produkSvc = 0;

            byte productExpired = 0;
            if (expiredCheckBox.Checked)
                productExpired = 1;
            else
                productExpired = 0;

            byte produkStatus = 0;
            if (nonAktifCheckbox.Checked)
                produkStatus = 0;
            else
                produkStatus = 1;

            string produkPhoto = " ";
            if (!selectedPhoto.Equals(""))
                produkPhoto = productID + ".jpg";

            DS.beginTransaction();

            try
            {
                DS.mySqlConnect();

                if (globalFeatureList.EXPIRY_MODULE == 1 && productExpired == 1)
                {
                    int lotIDValue;
                    
                    // INSERT OR UPDATE PRODUCT EXPIRY
                    for (int i = 0;i<expDataGridView.Rows.Count-1;i++)
                    {
                        if (null != expDataGridView.Rows[i].Cells["lotID"].Value)
                            lotIDValue = Convert.ToInt32(expDataGridView.Rows[i].Cells["lotID"].Value);
                        else
                            lotIDValue = 0;

                        DateTime productExpiryDateValue = Convert.ToDateTime(expDataGridView.Rows[i].Cells["expiryDateValue"].Value.ToString());
                        string productExpiryDate = String.Format(culture, "{0:dd-MM-yyyy}", productExpiryDateValue);
                        double lotProductQty = Convert.ToDouble(expDataGridView.Rows[i].Cells["qty"].Value);
                        int expiryActive = 1;

                        if (Convert.ToBoolean(expDataGridView.Rows[i].Cells["status"].Value) == false)
                            expiryActive = 0;
                        else
                            expiryActive = 1;

                        if (lotIDValue == 0) // NEW EXPIRY DATE
                        {
                            sqlCommand = "INSERT INTO PRODUCT_EXPIRY (PRODUCT_ID, PRODUCT_EXPIRY_DATE, PRODUCT_AMOUNT, EXPIRY_ACTIVE) VALUES ( '" + productID + "', STR_TO_DATE('" + productExpiryDate + "', '%d-%m-%Y'), " + lotProductQty + ", " + expiryActive + ")";
                            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "INSERT TO PRODUCT EXPIRY [" + productExpiryDate + "]");
                        }
                        else
                        {
                            sqlCommand = "UPDATE PRODUCT_EXPIRY SET PRODUCT_EXPIRY_DATE = STR_TO_DATE('" + productExpiryDate + "', '%d-%m-%Y'), PRODUCT_AMOUNT = " + lotProductQty + ", EXPIRY_ACTIVE = " + expiryActive + " WHERE ID = " + lotIDValue;
                            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "UPDATE PRODUCT EXPIRY [" + lotIDValue + "]");
                        }

                        if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                            throw internalEX;
                    }

                    // DELETE PRODUCT EXPIRY
                    for (int i = 0; i < expDataGridViewHidden.Rows.Count-1; i++)
                    {
                        lotIDValue = Convert.ToInt32(expDataGridViewHidden.Rows[i].Cells["lotID"].Value);
                        sqlCommand = "UPDATE PRODUCT_EXPIRY SET IS_DELETED = 1 WHERE ID = " + lotIDValue;

                        gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "DELETE PRODUCT EXPIRY [" + lotIDValue + "]");
                        if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                            throw internalEX;
                    }

                    if (produkStatus == 0)
                    {
                        // SET ALL PRODUCT EXPIRY TO INACTIVE
                        sqlCommand = "UPDATE PRODUCT_EXPIRY SET EXPIRY_ACTIVE = 0 WHERE PRODUCT_ID = '" + productID + "'";
                        if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                            throw internalEX;
                    }
                    //// INSERT TO PRODUCT_EXPIRY
                    //DateTime productExpiryDateValue = expDatePicker.Value;
                    //string productExpiryDate = String.Format(culture, "{0:dd-MM-yyyy}", productExpiryDateValue);

                    //string productID = kodeProdukTextBox.Text;
                    //expiryModuleUtil expUtil = new expiryModuleUtil();

                    //// CHECK WHETHER THE PRODUCT WITH SAME EXPIRY DATE EXIST
                    //lotID = expUtil.getLotIDBasedOnExpiryDate(productExpiryDateValue, productID);

                    //if (lotID == 0) // NEW EXPIRY DATE
                    //    //sqlCommand = "INSERT INTO PRODUCT_EXPIRY (PRODUCT_ID, PRODUCT_EXPIRY_DATE, PRODUCT_AMOUNT, PR_INVOICE) VALUES ( '" + detailGridView.Rows[i].Cells["productID"].Value.ToString() + "', STR_TO_DATE('" + productExpiryDate + "', '%d-%m-%Y'), " + Convert.ToDouble(detailGridView.Rows[i].Cells["qtyReceived"].Value) + ", '" + PRInvoice + "')";
                    //    sqlCommand = "INSERT INTO PRODUCT_EXPIRY (PRODUCT_ID, PRODUCT_EXPIRY_DATE, PRODUCT_AMOUNT) VALUES ( '" + productID + "', STR_TO_DATE('" + productExpiryDate + "', '%d-%m-%Y'), " + produkQty + ")";
                    //else
                    //{
                    //    newProdukQty = Convert.ToDouble(produkQty);
                    //     //selectedProductOriginalTotalQty = selectedProductOriginalTotalQty + deltaQty;

                    //    //produkQty = selectedProductOriginalTotalQty.ToString();
                    //    sqlCommand = "UPDATE PRODUCT_EXPIRY SET PRODUCT_AMOUNT = " + newProdukQty + " WHERE ID = " + lotID;
                    //}
                    //gUtil.saveSystemDebugLog(globalConstants.MENU_PENERIMAAN_BARANG, "INSERT TO PRODUCT EXPIRY [" + productID + "]");
                    //if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                    //    throw internalEX;
                }
                else if (globalFeatureList.EXPIRY_MODULE == 1 && productExpired == 0)
                {
                    // SET FLAG IS_DELETED TO 1
                    // SET ALL PRODUCT EXPIRY TO INACTIVE
                    sqlCommand = "UPDATE PRODUCT_EXPIRY SET IS_DELETED = 1 WHERE PRODUCT_ID = '" + productID + "'";
                    if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                        throw internalEX;
                }

                switch (originModuleID)
                {
                    case globalConstants.EDIT_PRODUK:
                        if (globalFeatureList.EXPIRY_MODULE == 0)
                        { 
                            // UPDATE MASTER_PRODUK TABLE
                            sqlCommand = "UPDATE MASTER_PRODUCT SET " +
                                                "PRODUCT_BARCODE = '" + produkBarcode + "', " +
                                                "PRODUCT_NAME =  '" + produkName + "', " +
                                                "PRODUCT_DESCRIPTION =  '" + produkDesc + "', " +
                                                "PRODUCT_BASE_PRICE = " + produkHargaPokok + ", " +
                                                "PRODUCT_RETAIL_PRICE = " + produkHargaEcer + ", " +
                                                "PRODUCT_BULK_PRICE =  " + produkHargaPartai + ", " +
                                                "PRODUCT_WHOLESALE_PRICE = " + produkHargaGrosir + ", " +
                                                "PRODUCT_PHOTO_1 = '" + produkPhoto + "', " +
                                                "UNIT_ID = " + selectedUnitID + ", " +
                                                "PRODUCT_STOCK_QTY = " + produkQty + ", " +
                                                "PRODUCT_LIMIT_STOCK = " + limitStock + ", " +
                                                "PRODUCT_SHELVES = '" + produkShelves + "', " +
                                                "PRODUCT_ACTIVE = " + produkStatus + ", " +
                                                "PRODUCT_BRAND = '" + produkBrand + "', " +
                                                "PRODUCT_IS_SERVICE = " + produkSvc + ", " +
                                                "PRODUCT_EXPIRABLE = " + productExpired + " " +
                                                "WHERE PRODUCT_ID = '" + productID + "'";
                        }
                        else
                        {
                            sqlCommand = "UPDATE MASTER_PRODUCT SET " +
                                                "PRODUCT_BARCODE = '" + produkBarcode + "', " +
                                                "PRODUCT_NAME =  '" + produkName + "', " +
                                                "PRODUCT_DESCRIPTION =  '" + produkDesc + "', " +
                                                "PRODUCT_BASE_PRICE = " + produkHargaPokok + ", " +
                                                "PRODUCT_RETAIL_PRICE = " + produkHargaEcer + ", " +
                                                "PRODUCT_BULK_PRICE =  " + produkHargaPartai + ", " +
                                                "PRODUCT_WHOLESALE_PRICE = " + produkHargaGrosir + ", " +
                                                "PRODUCT_PHOTO_1 = '" + produkPhoto + "', " +
                                                "UNIT_ID = " + selectedUnitID + ", ";

                            //if (lotID == 0)
                            //{
                            //    sqlCommand = sqlCommand + "PRODUCT_STOCK_QTY = PRODUCT_STOCK_QTY + " + produkQty + ", ";
                            //}
                            //else
                            //{
                            //    deltaQty = newProdukQty - selectedProductOriginalQty;
                            //    sqlCommand = sqlCommand + "PRODUCT_STOCK_QTY = PRODUCT_STOCK_QTY + " + deltaQty + ", ";
                            //}
                            sqlCommand = sqlCommand + "PRODUCT_STOCK_QTY = " + produkQty + ", ";
                            sqlCommand = sqlCommand + "PRODUCT_LIMIT_STOCK = " + limitStock + ", " +
                                                "PRODUCT_SHELVES = '" + produkShelves + "', " +
                                                "PRODUCT_ACTIVE = " + produkStatus + ", " +
                                                "PRODUCT_BRAND = '" + produkBrand + "', " +
                                                "PRODUCT_IS_SERVICE = " + produkSvc + ", " +
                                                "PRODUCT_EXPIRABLE = " + productExpired + " " +
                                                "WHERE PRODUCT_ID = '" + productID + "'";
                        }

                        gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "UPDATE CURRENT PRODUCT DATA [" + productID + "]");
                        if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                            throw internalEX;

                            // UPDATE PRODUCT_CATEGORY TABLE
                            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "UPDATE PRODUCT CATEGORY FOR [" + productID + "]");

                            // delete the content first, and insert the new data based on the currentSelectedKategoryID LIST
                            sqlCommand = "DELETE FROM PRODUCT_CATEGORY WHERE PRODUCT_ID = '" + productID + "'";
                            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "DELETE CURRENT PRODUCT CATEGORY FOR [" + productID + "]");
                            if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                                throw internalEX;

                            // SAVE TO PRODUCT_CATEGORY TABLE
                            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "INSERT PRODUCT CATEGORY FOR [" + productID + "]");

                            for (int i = 0; i < currentSelectedKategoriID.Count(); i++)
                            {
                                sqlCommand = "INSERT INTO PRODUCT_CATEGORY (PRODUCT_ID, CATEGORY_ID) VALUES ('" + productID + "', " + currentSelectedKategoriID[i] + ")";
                                if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                                    throw internalEX;
                            }

                        // DELETE FROM PRODUCT EXPIRY
                        if (globalFeatureList.EXPIRY_MODULE == 1 && productExpired == 0)
                        {
                            sqlCommand = "DELETE FROM PRODUCT_EXPIRY WHERE PRODUCT_ID = '" + productID + "'";
                            if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                                throw internalEX;
                        }
                        break;

                    default: // NEW PRODUK
                        // SAVE TO MASTER_PRODUK TABLE
                        sqlCommand = "INSERT INTO MASTER_PRODUCT " +
                                            "(PRODUCT_ID, PRODUCT_BARCODE, PRODUCT_NAME, PRODUCT_DESCRIPTION, PRODUCT_BASE_PRICE, PRODUCT_RETAIL_PRICE, PRODUCT_BULK_PRICE, PRODUCT_WHOLESALE_PRICE, PRODUCT_PHOTO_1, UNIT_ID, PRODUCT_STOCK_QTY, PRODUCT_LIMIT_STOCK, PRODUCT_SHELVES, PRODUCT_ACTIVE, PRODUCT_BRAND, PRODUCT_IS_SERVICE, PRODUCT_EXPIRABLE) " +
                                            "VALUES " +
                                            "('" + productID + "', '" + produkBarcode + "', '" + produkName + "', '" + produkDesc + "', " + produkHargaPokok + ", " + produkHargaEcer + ", " + produkHargaPartai + ", " + produkHargaGrosir + ", '" + produkPhoto + "', " + selectedUnitID + ", " + produkQty + ", " + limitStock + ", '" + produkShelves + "', " + produkStatus + ", '" + produkBrand + "', " + produkSvc + ", " + productExpired + ")";

                        gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "INSERT NEW PRODUCT [" + productID + "]");

                        if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                            throw internalEX;

                        // SAVE TO PRODUCT_CATEGORY TABLE
                        gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "INSERT PRODUCT CATEGORY FOR [" + productID + "]");

                        for (int i = 0; i < currentSelectedKategoriID.Count(); i++)
                        {
                            sqlCommand = "INSERT INTO PRODUCT_CATEGORY (PRODUCT_ID, CATEGORY_ID) VALUES ('" + productID + "', " + currentSelectedKategoriID[i] + ")";
                            if (!DS.executeNonQueryCommand(sqlCommand, ref internalEX))
                                throw internalEX;
                        }
                        break;
                }

                if (!selectedPhoto.Equals("PRODUCT_PHOTO/" + produkPhoto) && !selectedPhoto.Equals(""))// && result == true)
                {
                    gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "SET PRODUCT IMAGE [" + selectedPhoto + "]");

                    panelImage.BackgroundImage = null;
                    System.IO.File.Copy(selectedPhoto, "PRODUCT_PHOTO/" + produkPhoto + "_temp");
                    gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "COPY SELECTED IMAGE TO PRODUCT_PHOTO FOLDER");

                    if (System.IO.File.Exists("PRODUCT_PHOTO/" + produkPhoto))
                    {
                        gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "DELETE CURRENT PRODUCT IMAGE [" + productID + "]");

                        System.GC.Collect();
                        System.GC.WaitForPendingFinalizers();
                        System.IO.File.Delete("PRODUCT_PHOTO/" + produkPhoto);
                    }

                    System.IO.File.Move("PRODUCT_PHOTO/" + produkPhoto + "_temp", "PRODUCT_PHOTO/" + produkPhoto);
                    panelImage.BackgroundImage = Image.FromFile("PRODUCT_PHOTO/" + produkPhoto);

                    gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "RENAME AND SET NEW PRODUCT IMAGE");
                }

                DS.commit();
                result = true;
            }
            catch (Exception e)
            {
                gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "EXCEPTION THROWN [" + e.Message+ "]");
                try
                {
                    DS.rollBack();
                }
                catch (MySqlException ex)
                {
                    if (DS.getMyTransConnection() != null)
                    {
                        gUtil.showDBOPError(ex, "ROLLBACK");
                    }
                }

                gUtil.showDBOPError(e, "ROLLBACK");
                result = false;
            }
            finally
            {
               
                DS.mySqlClose();
            }

            return result;
        }

        private bool saveData()
        {
            bool result = false; 
            if (dataValidated())
            {
                smallPleaseWait pleaseWait = new smallPleaseWait();
                pleaseWait.Show();

                //  ALlow main UI thread to properly display please wait form.
                Application.DoEvents();
                result = saveDataTransaction();

                pleaseWait.Close();

                return result;
            }

            return false;
        }

        private int getInternalProductID(string productID)
        {
            int result;
            DS.mySqlConnect();

            result = Convert.ToInt32(DS.getDataSingleValue("SELECT ID FROM MASTER_PRODUCT WHERE PRODUCT_ID = '" + productID + "'"));

            return result;
        }

        private void saveButton_Click(object sender, EventArgs e)
        {
            int internalProductID;
            if (saveData())
            {
                gUtil.showSuccess(options);

                if (originModuleID == globalConstants.NEW_PRODUK)
                {
                    kodeProdukTextBox.Select();
                }
                else
                {
                    //barcodeTextBox.Select();
                    this.Close();
                }

                if (originModuleID == globalConstants.STOK_PECAH_BARANG)
                {
                    internalProductID = getInternalProductID(productID);
                    parentForm.setNewSelectedProductID(internalProductID);

                    this.Close();
                }

                switch (originModuleID)
                {
                    case globalConstants.NEW_PRODUK:
                        gUtil.saveUserChangeLog(globalConstants.MENU_PRODUK, globalConstants.CHANGE_LOG_INSERT, "INSERT NEW PRODUK [" + namaProdukTextBox.Text + "]");
                        break;
                    case globalConstants.EDIT_PRODUK:
                        if (nonAktifCheckbox.Checked == true)
                            gUtil.saveUserChangeLog(globalConstants.MENU_PRODUK, globalConstants.CHANGE_LOG_UPDATE, "UPDATE PRODUK [" + namaProdukTextBox.Text + "] STATUS PRODUK NON-AKTIF");
                        else
                            gUtil.saveUserChangeLog(globalConstants.MENU_PRODUK, globalConstants.CHANGE_LOG_UPDATE, "UPDATE PRODUK [" + namaProdukTextBox.Text + "] STATUS PRODUK AKTIF");
                        break;
                }

                gUtil.ResetAllControls(this);
                clearUpProductCategory();

                stokAwalTextBox.Text = "0";
                limitStokTextBox.Text = "0";
                hppTextBox.Text = "0";
                hargaEcerTextBox.Text = "0";
                hargaGrosirTextBox.Text = "0";
                hargaPartaiTextBox.Text = "0";

                selectedPhoto = "";
                panelImage.BackgroundImage = null;
                
                errorLabel.Text = "";
                
                originModuleID = globalConstants.NEW_PRODUK;
                options = gUtil.INS;
                kodeProdukTextBox.Enabled = true;
            }
        }

        private bool productIDExist(string productID)
        {
            bool result = false;

            if (!DS.getDataSingleValue("SELECT COUNT(1) FROM MASTER_PRODUCT WHERE PRODUCT_ID = '"+ productID + "'").ToString().Equals("0"))
            {
                result = true;
            }

            return result;
        }

        private bool barcodeExist()
        {
            bool result = false;

            if (!DS.getDataSingleValue("SELECT COUNT(1) FROM MASTER_PRODUCT WHERE PRODUCT_BARCODE = '" + barcodeTextBox.Text + "'").ToString().Equals("0"))
            {
                result = true;
            }

            return result;
        }

        private void kodeProdukTextBox_TextChanged(object sender, EventArgs e)
        {
            string kodeProdukValue;

            if (isLoading)
                return;

            if (kodeProdukTextBox.Text.IndexOf('\'') >= 0)
                kodeProdukTextBox.Text = kodeProdukTextBox.Text.Remove(kodeProdukTextBox.Text.IndexOf('\''), 1);

            kodeProdukValue = MySqlHelper.EscapeString(gUtil.allTrim(kodeProdukTextBox.Text));

            if ((productIDExist(kodeProdukValue)) && (originModuleID != globalConstants.EDIT_PRODUK))
            {
                errorLabel.Text = "PRODUK ID SUDAH ADA";
                kodeProdukTextBox.Focus();
                //kodeProdukTextBox.BackColor = Color.Red;
            }
            else
            {
                errorLabel.Text = "";
                //kodeProdukTextBox.BackColor = Color.White;
            }
        }

        private void resetbutton_Click(object sender, EventArgs e)
        {
            isLoading = true;

            gUtil.ResetAllControls(this);

            stokAwalTextBox.Text = "0";
            limitStokTextBox.Text = "0";
            hppTextBox.Text = "0";
            hargaEcerTextBox.Text = "0";
            hargaGrosirTextBox.Text = "0";
            hargaPartaiTextBox.Text = "0";

            selectedPhoto = "";
            panelImage.BackgroundImage = null;
            
            errorLabel.Text = "";
            
            currentSelectedKategoriID.Clear();
            originModuleID = globalConstants.NEW_PRODUK;
            options = gUtil.INS;
            kodeProdukTextBox.Enabled = true;

            isLoading = false;
        }

        private void barcodeTextBox_TextChanged(object sender, EventArgs e)
        {
            if (isLoading)
                return;

            barcodeTextBox.Text = gUtil.allTrim(barcodeTextBox.Text);

            if (barcodeTextBox.Text.Length > 0 && (barcodeExist()) && (originModuleID == globalConstants.NEW_PRODUK))
            {
                errorLabel.Text = "BARCODE SUDAH ADA";
                barcodeTextBox.Focus();
                barcodeTextBox.BackColor = Color.Red;
            }
            else
            {
                errorLabel.Text = "";
                barcodeTextBox.BackColor = Color.White;
            }
        }

        private void LoadLastSupplier()
        {
            string sqlCommand;
            MySqlDataReader rdr;
            string supplierName = "";
            DS.mySqlConnect();

            sqlCommand = "SELECT IFNULL(M.SUPPLIER_FULL_NAME, '') AS 'NAMA SUPPLIER', H.LAST_SUPPLY AS TANGGAL FROM MASTER_SUPPLIER M, SUPPLIER_HISTORY H WHERE H.PRODUCT_ID = '" + kodeProdukTextBox.Text + "' AND M.SUPPLIER_ID = H.SUPPLIER_ID ORDER BY TANGGAL DESC LIMIT 1";
    
            using (rdr = DS.getData(sqlCommand))
            {
                if (rdr.HasRows)
                {
                    rdr.Read();
                    supplierName = rdr.GetString("NAMA SUPPLIER");
                }
            }

            if (supplierName.Equals(""))
            {
                SupplierHistoryButton.Enabled = false;
            }
            else
            {
                SupplierTextBox.Text = supplierName;
            }
        }

        private void dataProdukDetailForm_Load(object sender, EventArgs e)
        {
            int userAccessOption = 0;
            Button[] arrButton = new Button[2];

            errorLabel.Text = "";

            expDataGridView.EditingControlShowing += expDataGridView_EditingControlShowing;
            //if (globalFeatureList.EXPIRY_MODULE == 1)
            //{
            //    expLabel.Visible = true;
            //    expDatePicker.Visible = true;
            //}
            isLoading = true;

            expDataGridView.ReadOnly = true;
            expDataGridView.Enabled = false;

            oDateTimePicker.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            addExpDataGridColumn();

            if (originModuleID == globalConstants.EDIT_PRODUK)
            { 
                loadProdukData();

                loadProdukExpData();

                loadUnitIDInformation();

                loadProductCategoryData();

                loadKategoriIDInformation();

                LoadLastSupplier();
            }

            switch (originModuleID)
            {
                case globalConstants.NEW_PRODUK:
                case globalConstants.STOK_PECAH_BARANG:
                    options = gUtil.INS;
                    kodeProdukTextBox.Enabled = true;
                    break;
                case globalConstants.EDIT_PRODUK:
                    options = gUtil.UPD;
                    kodeProdukTextBox.Enabled = false;
                    break;
            }
            isLoading = false;

            userAccessOption = DS.getUserAccessRight(globalConstants.MENU_TAMBAH_PRODUK, gUtil.getUserGroupID());

            if (originModuleID == globalConstants.NEW_PRODUK)
            {
                if (userAccessOption != 2 && userAccessOption != 6)
                {
                    gUtil.setReadOnlyAllControls(this);
                }
                kodeProdukTextBox.Select();
            }
            else if (originModuleID == globalConstants.EDIT_PRODUK)
            {
                if (userAccessOption != 4 && userAccessOption != 6)
                {
                    gUtil.setReadOnlyAllControls(this);
                }

                if (globalFeatureList.EXPIRY_MODULE == 1)
                {
                    //                    expLabel.Visible = false;
                    //                    expDatePicker.Visible = false;
                    //expDatePicker.Enabled = false;
                }
                namaProdukTextBox.Select();
            }

            arrButton[0] = saveButton;
            arrButton[1] = resetbutton;
            gUtil.reArrangeButtonPosition(arrButton, arrButton[0].Top, this.Width);

            //expDatePicker.Format = DateTimePickerFormat.Custom;
            //expDatePicker.CustomFormat = globalUtilities.CUSTOM_DATE_FORMAT;

            gUtil.reArrangeTabOrder(this);

        }

        private void namaProdukTextBox_TextChanged(object sender, EventArgs e)
        {
            if (namaProdukTextBox.Text.IndexOf('\'') >= 0)
                namaProdukTextBox.Text = namaProdukTextBox.Text.Remove(namaProdukTextBox.Text.IndexOf('\''), 1);
        }

        private void produkDescTextBox_TextChanged(object sender, EventArgs e)
        {
            if (produkDescTextBox.Text.IndexOf('\'') >= 0)
                produkDescTextBox.Text = produkDescTextBox.Text.Remove(produkDescTextBox.Text.IndexOf('\''), 1);
        }

        private void noRakKolomTextBox_Enter(object sender, EventArgs e)
        {
            BeginInvoke((Action)delegate
            {
                noRakKolomTextBox.SelectAll();
            });
            //noRakKolomTextBox.Focus();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            //PRINT BARCODE
            string sqlCommandx = "SELECT PRODUCT_ID AS 'ID', CONCAT('*',PRODUCT_BARCODE,'*') AS 'BARCODE1', PRODUCT_BARCODE AS 'BARCODE2', PRODUCT_NAME AS 'NAME', PRODUCT_BRAND AS ' BRAND', PRODUCT_RETAIL_PRICE AS 'PRICE'" +
                                    " FROM master_product" +
                                    " WHERE PRODUCT_ID = '" + kodeProdukTextBox.Text + "'";
            DS.writeXML(sqlCommandx, globalConstants.PrintBarcodeXML);
            PrintBarcodeForm displayedForm = new PrintBarcodeForm();
            displayedForm.ShowDialog(this);
        }

        private void dataProdukDetailForm_Activated(object sender, EventArgs e)
        {
            registerGlobalHotkey();
        }

        private void dataProdukDetailForm_Deactivate(object sender, EventArgs e)
        {
            unregisterGlobalHotkey();
        }

        private void produkJasaCheckbox_CheckedChanged(object sender, EventArgs e)
        {
            if (produkJasaCheckbox.Checked)
            {
                // PRODUCT IS SERVICE
                stokAwalTextBox.Enabled = false;
                limitStokTextBox.Enabled = false;
                //expDatePicker.Enabled = false;
                expiredCheckBox.Enabled = false;
            }
            else
            {
                stokAwalTextBox.Enabled = true;
                limitStokTextBox.Enabled = true;
                //expDatePicker.Enabled = true;
                expiredCheckBox.Enabled = true;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            clearUpProductCategory();
        }

        private void kodeProdukTextBox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                barcodeTextBox.Select();
            }
        }

        private void barcodeTextBox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                namaProdukTextBox.Select();
            }
        }

        private void produkKategoriTextBox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F11)
            {
                searchKategoriButton.PerformClick();
            }
        }

        private void unitTextBox_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F11)
            {
                searchUnitButton.PerformClick();
            }
        }

        private void SupplierHistoryButton_Click(object sender, EventArgs e)
        {
            //TAMPILKAN LIST OF SUPPLIER HISTORY FORM
            if (null == HistoryForm || HistoryForm.IsDisposed)
                HistoryForm = new SupplierHistoryForm(kodeProdukTextBox.Text);

            HistoryForm.Show();
            HistoryForm.WindowState = FormWindowState.Normal;
        }

        private void expiredCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            double currentQty = 0;
            double expQty = 0;

            currentQty = Convert.ToDouble(stokAwalTextBox.Text);

            if (isLoading)
                return;

            if (expiredCheckBox.Checked)
            {
                stokAwalTextBox.Enabled = false;
                expDataGridView.ReadOnly = false;
                expDataGridView.Enabled = true;

                isLoading = true;
                expDataGridView.Rows.Clear();
                //expDataGridView.AllowUserToAddRows = true;

                if (expDataGridView.Rows.Count > 0)
                { 
                    expDataGridView.Rows[0].Cells["lotID"].Value = 0;
                    expDataGridView.Rows[0].Cells["status"].Value = true;
                }
                loadProdukExpData();
                calculateTotalQty();

                expQty = Convert.ToDouble(stokAwalTextBox.Text);
                
                if (currentQty != expQty && expQty > 0)
                {
                    if (DialogResult.No == MessageBox.Show("LOAD DATA YG LAMA?", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation))
                    {
                        // CLEAR DATA GRID
                        deleteAllRow();

                        expDataGridView.Rows.Add();
                        // ADD NEW ROW BASED ON CURRENT STOCK QTY DATA
                        string expDateValue = String.Format(culture, "{0:" + globalUtilities.CUSTOM_DATE_FORMAT + "}", DateTime.Now);
                        //expDataGridView.Rows.Add(rdr.GetString("ID"), checkBoxValue, rdr.GetString("PRODUCT_AMOUNT"), expDateValue, rdr.GetString("PRODUCT_EXPIRY_DATE"));

                        expDataGridView.Rows[0].Cells["lotID"].Value = 0;
                        expDataGridView.Rows[0].Cells["status"].Value = true;
                        expDataGridView.Rows[0].Cells["qty"].Value = currentQty;
                        expDataGridView.Rows[0].Cells["expiryDate"].Value = expDateValue;
                        expDataGridView.Rows[0].Cells["expiryDateValue"].Value = DateTime.Now;

                        stokAwalTextBox.Text = currentQty.ToString();
                    }
                }
                else if (expQty == 0)
                {
                    // ADD NEW ROW BASED ON CURRENT STOCK QTY DATA
                    string expDateValue = String.Format(culture, "{0:" + globalUtilities.CUSTOM_DATE_FORMAT + "}", DateTime.Now);
                    //expDataGridView.Rows.Add(rdr.GetString("ID"), checkBoxValue, rdr.GetString("PRODUCT_AMOUNT"), expDateValue, rdr.GetString("PRODUCT_EXPIRY_DATE"));

                    expDataGridView.Rows.Add();
                    //expDataGridView.AllowUserToAddRows = true;

                    expDataGridView.Rows[0].Cells["lotID"].Value = 0;
                    expDataGridView.Rows[0].Cells["status"].Value = true;
                    expDataGridView.Rows[0].Cells["qty"].Value = currentQty;
                    expDataGridView.Rows[0].Cells["expiryDate"].Value = expDateValue;
                    expDataGridView.Rows[0].Cells["expiryDateValue"].Value = DateTime.Now;

                    calculateTotalQty();
                }


                showInactiveExpiryCheckBox.Enabled = true;

                isLoading = false;

            }
            else
            {
                if (DialogResult.Yes == MessageBox.Show("SEMUA DATA EXP DATE AKAN DIHAPUS, LANJUTKAN?", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation))
                {
                    expDataGridView.Rows.Clear();
                    stokAwalTextBox.Enabled = true;
                    expDataGridView.ReadOnly = true;
                    expDataGridView.Enabled = false;
                    showInactiveExpiryCheckBox.Checked= false;
                    showInactiveExpiryCheckBox.Enabled = false;
                }
                else
                    expiredCheckBox.Checked = true;
            }
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void noRakBarisTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        private void addExpDataGridColumn()
        {
            DataGridViewTextBoxColumn lotID_textBox = new DataGridViewTextBoxColumn();
            DataGridViewTextBoxColumn qty_textBox = new DataGridViewTextBoxColumn();
            DataGridViewTextBoxColumn expiryDate_textBox = new DataGridViewTextBoxColumn();
            DataGridViewTextBoxColumn expiryDateValue_textBox = new DataGridViewTextBoxColumn();
            DataGridViewCheckBoxColumn status_checkBox = new DataGridViewCheckBoxColumn();

            lotID_textBox.Name = "lotID";
            lotID_textBox.HeaderText = "LOT ID";
            lotID_textBox.Visible = false;
            expDataGridView.Columns.Add(lotID_textBox);

            status_checkBox.Name = "status";
            status_checkBox.HeaderText = "AKTIF";
            expDataGridView.Columns.Add(status_checkBox);

            qty_textBox.Name = "qty";
            qty_textBox.HeaderText = "QTY";
            qty_textBox.DefaultCellStyle.BackColor = Color.LightBlue;
            expDataGridView.Columns.Add(qty_textBox);

            expiryDate_textBox.Name = "expiryDate";
            expiryDate_textBox.HeaderText = "KADALUARSA";
            expiryDate_textBox.ReadOnly = true;
            expDataGridView.Columns.Add(expiryDate_textBox);

            expiryDateValue_textBox.Name = "expiryDateValue";
            expiryDateValue_textBox.HeaderText = "KADALUARSA";
            expiryDateValue_textBox.ReadOnly = true;
            expiryDateValue_textBox.Visible = false;
            expDataGridView.Columns.Add(expiryDateValue_textBox);
        }

        private void expDataGridView_CellBeginEdit(object sender, DataGridViewCellCancelEventArgs e)
        {
            expDataGridView.SuspendLayout();

            if (navKeyRegistered)
            {
                unregisterGlobalHotkey();
            }

            if (!delKeyRegistered)
                registerDelKey();
        }

        private void expDataGridView_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            expDataGridView.ResumeLayout();
        }

        private void expDataGridView_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            var cell = expDataGridView[e.ColumnIndex, e.RowIndex];
            string columnName = "";

            if (expDataGridView.Rows.Count <= 0)
                return;

            columnName = cell.OwningColumn.Name;
            if (columnName == "expiryDate")
            {
                addDateTimePickerToDataGrid(e.ColumnIndex, e.RowIndex);
            }
        }

        private void expDataGridView_CellLeave(object sender, DataGridViewCellEventArgs e)
        {
            var cell = expDataGridView[e.ColumnIndex, e.RowIndex];
            string columnName = "";

            if (expDataGridView.Rows.Count <= 0)
                return;

            columnName = cell.OwningColumn.Name;

            if (globalFeatureList.EXPIRY_MODULE == 1)
            {
                if (columnName == "expiryDate")
                {
                    oDateTimePicker.Visible = false;
                }
            }
        }

        private void addDateTimePickerToDataGrid(int columnIndex, int rowIndex)
        {
            oDateTimePicker.TextChanged -= oDateTimePicker_OnTextChanged;
            //string expDateValue = String.Format(culture, "{0:" + globalUtilities.CUSTOM_DATE_FORMAT + "}", DateTime.Now);
            oDateTimePicker.Value = DateTime.Now;
            //oDateTimePicker.Text = expDateValue;

            expDataGridView.Controls.Add(oDateTimePicker);
            oDateTimePicker.Visible = false;
            oDateTimePicker.Format = DateTimePickerFormat.Custom;
            oDateTimePicker.CustomFormat = globalUtilities.CUSTOM_DATE_FORMAT;
            oDateTimePicker.TextChanged += new EventHandler(oDateTimePicker_OnTextChanged);

            if (null != expDataGridView.Rows[rowIndex].Cells["expiryDateValue"].Value)
                oDateTimePicker.Value = Convert.ToDateTime(expDataGridView.Rows[rowIndex].Cells["expiryDateValue"].Value);

            oDateTimePicker.Visible = true;

            Rectangle oRectangle = expDataGridView.GetCellDisplayRectangle(columnIndex, rowIndex, true);
            oDateTimePicker.Size = new Size(oRectangle.Width, oRectangle.Height);
            oDateTimePicker.Location = new Point(oRectangle.X, oRectangle.Y);
            oDateTimePicker.CloseUp += new EventHandler(oDateTimePicker_CloseUp);
        }

        private void oDateTimePicker_OnTextChanged(object sender, EventArgs e)
        {
            int rowIndex = expDataGridView.CurrentCell.RowIndex;

            expDataGridView.CurrentCell.Value = oDateTimePicker.Text.ToString();
            expDataGridView.Rows[rowIndex].Cells["expiryDateValue"].Value = oDateTimePicker.Value.ToString();
        }

        private void oDateTimePicker_CloseUp(object sender, EventArgs e)
        {
            oDateTimePicker.Visible = false;
        }

        private void expDataGridView_CellValidating(object sender, DataGridViewCellValidatingEventArgs e)
        {

        }

        private void calculateTotalQty()
        {
            double totalQty = 0;
            double expQty = 0;

            for (int i = 0; i<expDataGridView.Rows.Count; i++)
            {
                expQty = 0;
                if (null != expDataGridView.Rows[i].Cells["expiryDateValue"].Value && true == Convert.ToBoolean(expDataGridView.Rows[i].Cells["status"].Value))
                {
                    try
                    {
                        double.TryParse(expDataGridView.Rows[i].Cells["qty"].Value.ToString(), out expQty);
                    }
                    catch (Exception e) { }

                    totalQty = totalQty + expQty;
                }
            }

            stokAwalTextBox.Text = totalQty.ToString();
        }

        private void expDataGridView_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            var cell = expDataGridView[e.ColumnIndex, e.RowIndex];
            int rowSelectedIndex = 0;
            string cellValue = "";
            string columnName = "";

            if (isLoading)
                return;

            columnName = cell.OwningColumn.Name;
            gUtil.saveSystemDebugLog(globalConstants.MENU_TAMBAH_PRODUK, "DETAIL PRODUK : detailGridView_CellValueChanged [" + columnName + "]");

            rowSelectedIndex = e.RowIndex;
            DataGridViewRow selectedRow = expDataGridView.Rows[rowSelectedIndex];

            if (null != selectedRow.Cells[columnName].Value)
                cellValue = selectedRow.Cells[columnName].Value.ToString();
            else
                cellValue = "";

            if (columnName == "qty")
            {
                if (cellValue.Length <= 0)
                {
                    // IF TEXTBOX IS EMPTY, DEFAULT THE VALUE TO 0 AND EXIT THE CHECKING
                    isLoading = true;
                    // reset subTotal Value and recalculate total
                    selectedRow.Cells[columnName].Value = "0";
                    isLoading = false;
                    return;
                }

                if (!gUtil.matchRegEx(cellValue, globalUtilities.REGEX_NUMBER_WITH_2_DECIMAL)
                        && (cellValue.Length > 0))
                {
                    int rowIndex = rowSelectedIndex + 1;
                    errorLabel.Text = "INPUT QTY PADA BARIS [" + rowIndex  + "] SALAH";
                }
            }

            calculateTotalQty();
        }

        private void expDataGridView_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {
            if (isLoading)
                return;

            if (expDataGridView.Rows.Count - 2 > 0)
            {
                expDataGridView.Rows[expDataGridView.Rows.Count - 2].Cells["lotID"].Value = 0;
                expDataGridView.Rows[expDataGridView.Rows.Count - 2].Cells["status"].Value = true;
            }
        }

        private void expDataGridView_Leave(object sender, EventArgs e)
        {
            if (delKeyRegistered)
                unregisterDelKey();
        }

        private void expDataGridView_Enter(object sender, EventArgs e)
        {
            if (!delKeyRegistered)
                registerDelKey();
        }

        private void expDataGridView_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Delete)
            {
                if (DialogResult.Yes == MessageBox.Show("HAPUS BARIS YG DIPILIH?", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation))
                    deleteCurrentRow();
            }
        }

        private void expDataGridView_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            // +=
            if ((expDataGridView.CurrentCell.OwningColumn.Name == "qty")
                && e.Control is TextBox)
            {
                TextBox qtyTextBox = e.Control as TextBox;
                qtyTextBox.PreviewKeyDown -= qty_previewKeyDown;
                qtyTextBox.PreviewKeyDown += qty_previewKeyDown;
            }
        }

        private void qty_previewKeyDown(object sender, PreviewKeyDownEventArgs e)
        {
            if (e.KeyCode == Keys.Delete)
            {
                if (DialogResult.Yes == MessageBox.Show("HAPUS BARIS YG DIPILIH?", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation))
                    deleteCurrentRow();
            }
        }

        private void showInactiveExpiryCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            isLoading = true;
            expDataGridView.Rows.Clear();

            if (expDataGridView.Rows.Count > 0)
            {
                expDataGridView.Rows[0].Cells["lotID"].Value = 0;
                expDataGridView.Rows[0].Cells["status"].Value = true;
            }
            loadProdukExpData();
            calculateTotalQty();
            isLoading = false;
        }

        private void expDataGridView_CurrentCellDirtyStateChanged(object sender, EventArgs e)
        {
            if (expDataGridView.IsCurrentCellDirty)
            {
                expDataGridView.CommitEdit(DataGridViewDataErrorContexts.Commit);
            }
        }
    }
}
