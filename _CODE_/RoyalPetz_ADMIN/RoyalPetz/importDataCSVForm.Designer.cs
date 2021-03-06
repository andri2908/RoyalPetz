﻿namespace AlphaSoft
{
    partial class importDataCSVForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(importDataCSVForm));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.label20 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.importFileNameTextBox = new System.Windows.Forms.TextBox();
            this.searchKategoriButton = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.detailImportDataGrid = new System.Windows.Forms.DataGridView();
            this.importButton = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.exportDate = new System.Windows.Forms.Label();
            this.productID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productBarcode = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tglExpired = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productQty = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productRealQty = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.description = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tglExpiredValue = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.detailImportDataGrid)).BeginInit();
            this.SuspendLayout();
            // 
            // label20
            // 
            this.label20.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.label20.AutoSize = true;
            this.label20.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label20.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.label20.Location = new System.Drawing.Point(103, 44);
            this.label20.Name = "label20";
            this.label20.Size = new System.Drawing.Size(14, 18);
            this.label20.TabIndex = 42;
            this.label20.Text = ":";
            // 
            // label5
            // 
            this.label5.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.label5.Location = new System.Drawing.Point(10, 44);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(87, 18);
            this.label5.TabIndex = 41;
            this.label5.Text = "FILE CSV";
            // 
            // importFileNameTextBox
            // 
            this.importFileNameTextBox.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.importFileNameTextBox.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.importFileNameTextBox.Location = new System.Drawing.Point(123, 41);
            this.importFileNameTextBox.Name = "importFileNameTextBox";
            this.importFileNameTextBox.ReadOnly = true;
            this.importFileNameTextBox.Size = new System.Drawing.Size(544, 27);
            this.importFileNameTextBox.TabIndex = 39;
            // 
            // searchKategoriButton
            // 
            this.searchKategoriButton.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.searchKategoriButton.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("searchKategoriButton.BackgroundImage")));
            this.searchKategoriButton.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.searchKategoriButton.Location = new System.Drawing.Point(673, 42);
            this.searchKategoriButton.Name = "searchKategoriButton";
            this.searchKategoriButton.Size = new System.Drawing.Size(24, 24);
            this.searchKategoriButton.TabIndex = 40;
            this.searchKategoriButton.UseVisualStyleBackColor = true;
            this.searchKategoriButton.Click += new System.EventHandler(this.searchKategoriButton_Click);
            // 
            // panel1
            // 
            this.panel1.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.panel1.BackColor = System.Drawing.Color.SteelBlue;
            this.panel1.Location = new System.Drawing.Point(0, 1);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(817, 29);
            this.panel1.TabIndex = 43;
            // 
            // detailImportDataGrid
            // 
            this.detailImportDataGrid.AllowUserToAddRows = false;
            this.detailImportDataGrid.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.detailImportDataGrid.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.detailImportDataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.detailImportDataGrid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.productID,
            this.productBarcode,
            this.productName,
            this.tglExpired,
            this.productQty,
            this.productRealQty,
            this.description,
            this.tglExpiredValue});
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.detailImportDataGrid.DefaultCellStyle = dataGridViewCellStyle2;
            this.detailImportDataGrid.Location = new System.Drawing.Point(0, 131);
            this.detailImportDataGrid.Name = "detailImportDataGrid";
            this.detailImportDataGrid.RowHeadersVisible = false;
            this.detailImportDataGrid.Size = new System.Drawing.Size(817, 531);
            this.detailImportDataGrid.TabIndex = 44;
            this.detailImportDataGrid.Enter += new System.EventHandler(this.detailImportDataGrid_Enter);
            this.detailImportDataGrid.Leave += new System.EventHandler(this.detailImportDataGrid_Leave);
            // 
            // importButton
            // 
            this.importButton.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.importButton.Location = new System.Drawing.Point(318, 78);
            this.importButton.Name = "importButton";
            this.importButton.Size = new System.Drawing.Size(163, 37);
            this.importButton.TabIndex = 45;
            this.importButton.Text = "IMPORT DATA";
            this.importButton.UseVisualStyleBackColor = true;
            this.importButton.Click += new System.EventHandler(this.importButton_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // exportDate
            // 
            this.exportDate.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.exportDate.AutoSize = true;
            this.exportDate.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.exportDate.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.exportDate.Location = new System.Drawing.Point(10, 110);
            this.exportDate.Name = "exportDate";
            this.exportDate.Size = new System.Drawing.Size(87, 18);
            this.exportDate.TabIndex = 46;
            this.exportDate.Text = "FILE CSV";
            // 
            // productID
            // 
            this.productID.HeaderText = "KODE";
            this.productID.Name = "productID";
            this.productID.ReadOnly = true;
            // 
            // productBarcode
            // 
            this.productBarcode.HeaderText = "BARCODE";
            this.productBarcode.Name = "productBarcode";
            this.productBarcode.ReadOnly = true;
            // 
            // productName
            // 
            this.productName.HeaderText = "NAMA PRODUK";
            this.productName.Name = "productName";
            this.productName.ReadOnly = true;
            this.productName.Width = 200;
            // 
            // tglExpired
            // 
            this.tglExpired.HeaderText = "TGL EXP";
            this.tglExpired.Name = "tglExpired";
            // 
            // productQty
            // 
            this.productQty.HeaderText = "JUMLAH";
            this.productQty.Name = "productQty";
            this.productQty.ReadOnly = true;
            // 
            // productRealQty
            // 
            this.productRealQty.HeaderText = "JUMLAH RIIL";
            this.productRealQty.Name = "productRealQty";
            this.productRealQty.ReadOnly = true;
            // 
            // description
            // 
            this.description.HeaderText = "DESCRIPTION";
            this.description.Name = "description";
            this.description.Width = 200;
            // 
            // tglExpiredValue
            // 
            this.tglExpiredValue.HeaderText = "tglExpiredValue";
            this.tglExpiredValue.Name = "tglExpiredValue";
            this.tglExpiredValue.Visible = false;
            // 
            // importDataCSVForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FloralWhite;
            this.ClientSize = new System.Drawing.Size(817, 662);
            this.Controls.Add(this.exportDate);
            this.Controls.Add(this.importButton);
            this.Controls.Add(this.detailImportDataGrid);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.label20);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.importFileNameTextBox);
            this.Controls.Add(this.searchKategoriButton);
            this.MaximizeBox = false;
            this.Name = "importDataCSVForm";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "IMPORT DATA CSV";
            this.Activated += new System.EventHandler(this.importDataCSVForm_Activated);
            this.Deactivate += new System.EventHandler(this.importDataCSVForm_Deactivate);
            this.Load += new System.EventHandler(this.importDataCSVForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.detailImportDataGrid)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label20;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox importFileNameTextBox;
        private System.Windows.Forms.Button searchKategoriButton;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.DataGridView detailImportDataGrid;
        private System.Windows.Forms.Button importButton;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Label exportDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn productID;
        private System.Windows.Forms.DataGridViewTextBoxColumn productBarcode;
        private System.Windows.Forms.DataGridViewTextBoxColumn productName;
        private System.Windows.Forms.DataGridViewTextBoxColumn tglExpired;
        private System.Windows.Forms.DataGridViewTextBoxColumn productQty;
        private System.Windows.Forms.DataGridViewTextBoxColumn productRealQty;
        private System.Windows.Forms.DataGridViewTextBoxColumn description;
        private System.Windows.Forms.DataGridViewTextBoxColumn tglExpiredValue;
    }
}