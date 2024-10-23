using Microsoft.Win32;
using System;
using System.IO;
using System.Windows;
using JilbeMetricsConsole;

namespace JilbeMetricsWpf
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void btnSelectFile_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Ruby files (*.rb)|*.rb|All files (*.*)|*.*";
            if (openFileDialog.ShowDialog() == true)
            {
                TxtFilePath.Text = openFileDialog.FileName;
                LoadAndAnalyzeFile(openFileDialog.FileName);
            }
        }

        private void LoadAndAnalyzeFile(string filePath)
        {
            try
            {
                string fileContent = File.ReadAllText(filePath);
                TxtFileContent.Text = fileContent;

                var jilbe = new Jilb();
                var lexer = new Lexer(filePath);
                lexer.AnalyzeFile(jilbe);

                TxtMaxNest.Text = jilbe.GetMaxNest().ToString();
                TxtConditions.Text = jilbe.ConditionAmount.ToString();
                TxtOperators.Text = jilbe.OperatorAmount.ToString();
                TxtSaturation.Text = jilbe.GetConditionSaturation().ToString("F2");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}");
            }
        }
    }
}
