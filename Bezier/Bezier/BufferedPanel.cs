using System;
using System.Windows.Forms;

namespace Bezier {
    class BufferedPanel : Panel {
        public BufferedPanel() {
            this.DoubleBuffered = true;
            this.ResizeRedraw = true;
        }
    }
}
