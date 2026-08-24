module asmiva.qast;

/*

module asmiva.ast;

import std.stdio, infss, std.conv, std.string, csl.preprs._sbox;

int AL, AH, BL, BH, CL, CH, DL, DH;
short AX, BX, CX, DX;
bool CF, ZF, OF; 
interface Node {
    void execute();
}

class AlRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    }
    override void execute()
    {
        AL = value;
    }
}

class AHRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        AH = value;
    }
}

class BLRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        BL = value;
    }
}

class BHRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        BH = value;
    }
}

class CLRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        CL = value;
    }
}

class CHRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        CH = value;
    }
}

class DLRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        DL = value;
    }
}

class DHRegeisterValue : Node {
    int value;
    this(int value)
    {
        this.value = value;
    } 
    override void execute()
    {
        DH = value;
    }
}

class ZFRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        ZF = value;
    }
}

class OFRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        OF = value;
    }
}

class CFRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        CF = value;
    }
}

class OFRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        OF = value;
    }
}

class DXRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        OF = value;
    }
}

class CXRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        OF = value;
    }
}

class BXRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        OF = value;
    }
}

class AXRegeisterValue : Node {
    bool value;
    this(bool value)
    {
        this.value = value;
    } 
    override void execute()
    {
        OF = value;
    }
}

class CmpManager : Node {
    int value2;
    int value;
    this(int value, int value2)
    {
        this.value = value;
        this.value2 = value2;
    }
    override void execute()
    {
        if (value == value2)
        {
            ZF = true;
        } else ZF = false;
    }
}

class RegeisterReturn : Node
{
    string rename;
    this(string rename)
    {
        this.rename = rename;
    }
    override void execute()
    {
        //noting.
        rename = rename;
    }
    int return_8bit()
    {
        if (rename == "al")
        {
            return AL;
        } else if (rename == "ah")
        {
            return AH;
        } else if (rename == "bl")
        {
            return BL;
        } else if (rename == "bh")
        {
            return BH;
        } else if (rename == "cl")
        {
            return CL;
        } else if (rename == "ch")
        {
            return CH;
        } else if (rename == "dl")
        {
            return DL;
        } else if (rename == "dh")
        {
            return DH;
        }
    }
}


*/