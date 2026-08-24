using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net;
using System.IO;

namespace EkoIDE
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
        static void dn()
        {
            try
            {
                WebClient wbc = new WebClient();
                wbc.DownloadFile(
                    "http://raw.githubusercontent.com/ekolang/eko/refs/heads/main/win/ide/ver.txt",
                    "version.txt"
                );
            }
            catch (Exception aa)
            {
                dn();
            }
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            System.Net.ServicePointManager.SecurityProtocol =
    (System.Net.SecurityProtocolType)3072;
            const string ver = "0.0.1";
            //label1.Visible = false;
            Timer time = new Timer();
            time.Interval = 4000;
            time.Tick += delegate
            {
                time.Stop();
                //label1.Visible = true;
                dn();
                string verf = File.ReadAllText("version.txt").Trim();
                if (verf == ver)
                {
                    if (Directory.Exists("eko_src"))
                    {
                        Form2 jkak = new Form2();
                        jkak.Show();
                        this.Close();
                    }
                    else
                    {
                        AboutBox1 about = new AboutBox1();
                        about.Show();
                    }
                }
                else
                {
                    label1.Text = "Your version is outdate. Try to update it.";
                }
            };
            time.Start();
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {

        }
    }
}
