using System.IO;

namespace JilbeMetricsConsole;

public class Lexer
{
    private string filePath;

    public Lexer(string filePath)
    {
        this.filePath = filePath;
    }

    public void AnalyzeFile(Jilb jilbe)
    {
        using (StreamReader reader = new StreamReader(filePath))
        {
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                AnalyzeLine(line, jilbe);
            }
        }
    }

    private void AnalyzeLine(string line, Jilb jilbe)
    {
        string trimmedLine = line.Trim();

        if (trimmedLine.StartsWith("if") || trimmedLine.StartsWith("elsif") || trimmedLine.StartsWith("case"))
        {
            jilbe.ConditionAmount++;
            jilbe.Nest++;
            jilbe.CheckMax(jilbe.Nest);
        }
        else if (trimmedLine.StartsWith("end"))
        {
            jilbe.Nest = Math.Max(0, jilbe.Nest - 1);
        }

        if (!string.IsNullOrEmpty(trimmedLine) && !trimmedLine.StartsWith("#"))
        {
            jilbe.OperatorAmount++;
        }
    }
}
