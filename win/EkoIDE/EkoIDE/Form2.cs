using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.IO;
namespace EkoIDE
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            TreeNode root = treeView1.Nodes.Add("Eko");
            root.Nodes.Add("New Project");
            root.Nodes.Add("Open Project");
            root.Nodes.Add("Compile Eko");
            toolStripStatusLabel1.Text = "Compiling eko...";
            Timer ew = new Timer();
            ew.Interval = 3000;
            ew.Tick += delegate
            {
                ew.Stop();
                toolStripStatusLabel1.Text = "Eko Loaded.";
           
                ProcessStartInfo kk = new ProcessStartInfo();
                kk.FileName = "dub.exe";
                kk.Arguments = "build";
                kk.WorkingDirectory =
       Path.Combine(
           Application.StartupPath,
           @"src_eko\eko-alpha-0.0.4\src\runtime"
       );
                kk.CreateNoWindow = true;
                kk.RedirectStandardOutput = true;
                kk.UseShellExecute = false;
                kk.RedirectStandardError = true;
                Process ll = Process.Start(kk);
                ll.WaitForExit();
                if (File.Exists("eko-alpha-0.0.4\\src\\runtime\\marschiert.lib")){
                    toolStripStatusLabel1.Text = "Build Runtime finished.";
                } else {
                    using(FileStream lla = File.Create("log"))
                    {
                        string result = ll.StandardOutput.ReadToEnd();
                        string error = ll.StandardError.ReadToEnd();
                        byte[] info = new UTF8Encoding(true).GetBytes(result + "\r\n" + error);
                        lla.Write(info, 0, info.Length);
                    }
                    AboutBox3 mam = new AboutBox3();
                    mam.Show();
                }
            };
            ew.Start();
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {

        }

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {

        }
    }
}
