namespace JilbeMetricsConsole;

public class Jilb
{
    private int maxNest = 0;
    public int Nest { get; set; } = 0;
    public Stack<int> SavedNest { get; private set; } = new Stack<int>();
    public int OperatorAmount { get; set; } = 0;
    public int ConditionAmount { get; set; } = 0;

    public int GetMaxNest() => maxNest;

    public void CheckMax(int n)
    {
        if (maxNest < n)
        {
            maxNest = n - 1;
        }
    }

    public float GetConditionSaturation()
    {
        return OperatorAmount != 0 ? (float)ConditionAmount / OperatorAmount : -1f;
    }
}
