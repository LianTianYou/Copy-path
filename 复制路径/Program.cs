using System;
using System.Windows.Forms;

namespace 复制路径
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            Clipboard.SetText(args[0]);
        }
    }
}
