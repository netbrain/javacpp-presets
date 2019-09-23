// Targeted by JavaCPP version 1.5.2-SNAPSHOT: DO NOT EDIT THIS FILE

package org.bytedeco.hdf5;

import java.nio.*;
import org.bytedeco.javacpp.*;
import org.bytedeco.javacpp.annotation.*;

import static org.bytedeco.hdf5.global.hdf5.*;


/* Callback during link traversal */
@Properties(inherit = org.bytedeco.hdf5.presets.hdf5.class)
public class H5L_traverse_0_func_t extends FunctionPointer {
    static { Loader.load(); }
    /** Pointer cast constructor. Invokes {@link Pointer#Pointer(Pointer)}. */
    public    H5L_traverse_0_func_t(Pointer p) { super(p); }
    protected H5L_traverse_0_func_t() { allocate(); }
    private native void allocate();
    public native @Cast("hid_t") long call(@Cast("const char*") BytePointer link_name, @Cast("hid_t") long cur_group,
    @Const Pointer lnkdata, @Cast("size_t") long lnkdata_size, @Cast("hid_t") long lapl_id);
}
