using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using System.IO;
using System.Net;
using Ionic.Zip;
namespace EkoIDE
{
    partial class AboutBox2 : Form
    {
        public AboutBox2()
        {
            InitializeComponent();
            System.Net.ServicePointManager.SecurityProtocol =
   (System.Net.SecurityProtocolType)3072;
            WebClient wbb = new WebClient();
            wbb.DownloadFile(
                "https://raw.githubusercontent.com/ekolang/eko/refs/heads/main/win/ide/source_link.txt",
                "sourcelink.txt"
                );
            string link = File.ReadAllText("sourcelink.txt").Trim();
            progressBar1.Value = 20;
            wbb.DownloadFile(
                link,
                "source.zip"
            );
            progressBar1.Value = 50;
            if (Directory.Exists("src_eko"))
            {
                Directory.Delete("src_eko", true);
            }
            using (ZipFile zip = ZipFile.Read("source.zip"))
            {
                zip.ExtractAll("src_eko");
            }
            progressBar1.Value = 100;
            Timer tim = new Timer();
            tim.Interval = 4000;
            tim.Tick += delegate
            {
                tim.Stop();
                Form2 usu = new Form2();
                usu.Show();
                Form1 ka = new Form1();
                ka.Close();
                this.Close();
            };
            tim.Start();
        }

        #region Assembly Attribute Accessors

        public string AssemblyTitle
        {
            get
            {
                object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyTitleAttribute), false);
                if (attributes.Length > 0)
                {
                    AssemblyTitleAttribute titleAttribute = (AssemblyTitleAttribute)attributes[0];
                    if (titleAttribute.Title != "")
                    {
                        return titleAttribute.Title;
                    }
                }
                return System.IO.Path.GetFileNameWithoutExtension(Assembly.GetExecutingAssembly().CodeBase);
            }
        }

        public string AssemblyVersion
        {
            get
            {
                return Assembly.GetExecutingAssembly().GetName().Version.ToString();
            }
        }

        public string AssemblyDescription
        {
            get
            {
                object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyDescriptionAttribute), false);
                if (attributes.Length == 0)
                {
                    return "";
                }
                return ((AssemblyDescriptionAttribute)attributes[0]).Description;
            }
        }

        public string AssemblyProduct
        {
            get
            {
                object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyProductAttribute), false);
                if (attributes.Length == 0)
                {
                    return "";
                }
                return ((AssemblyProductAttribute)attributes[0]).Product;
            }
        }

        public string AssemblyCopyright
        {
            get
            {
                object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyCopyrightAttribute), false);
                if (attributes.Length == 0)
                {
                    return "";
                }
                return ((AssemblyCopyrightAttribute)attributes[0]).Copyright;
            }
        }

        public string AssemblyCompany
        {
            get
            {
                object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyCompanyAttribute), false);
                if (attributes.Length == 0)
                {
                    return "";
                }
                return ((AssemblyCompanyAttribute)attributes[0]).Company;
            }
        }
        #endregion

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void progressBar1_Click(object sender, EventArgs e)
        {

        }
    }
}
