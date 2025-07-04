//===- ValueTypes.td - ValueType definitions ---------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// ValueTypes.td - list of ValueType instances supported by the the
// CodeGen infrastructure.
//
//===----------------------------------------------------------------------===//

class ValueType<int size, int value> {
  string Namespace = "MVT";
  string LLVMName = NAME;
  int Size = size;
  int Value = value;
  int nElem = 1;
  ValueType ElementType = ?;
  bit isOverloaded = false;
  bit isInteger = false;
  bit isFP = false;
  bit isVector = false;
  bit isScalable = false;
  int NF = 0;
  bit isRISCVVecTuple = false;
  // Indicates this VT should be included in the
  // [FIRST_VALUETYPE,LAST_VALUETYPE] range.
  bit isNormalValueType = true;
}

class VTAny<int value> : ValueType<0, value> {
  let isOverloaded = true;
}

class VTInt<int size, int value>
    : ValueType<size, value> {
  let isInteger = true;
}

class VTFP<int size, int value>
    : ValueType<size, value> {
  let isFP = true;
}

class VTVec<int nelem, ValueType elt, int value>
    : ValueType<!mul(nelem, elt.Size), value> {
  let nElem = nelem;
  let ElementType = elt;
  let isInteger = elt.isInteger;
  let isFP = elt.isFP;
  let isVector = true;
}

class VTScalableVec<int nelem, ValueType elt, int value>
    : VTVec<nelem, elt, value> {
  let isScalable = true;
}

class VTVecTup<int size, int nf, ValueType dummy_elt, int value>
    : ValueType<size, value> {
  let NF = nf;
  let ElementType = dummy_elt;
  let isRISCVVecTuple = true;
}

defset list<ValueType> ValueTypes = {

def OtherVT : ValueType<0,   1> {  // "Other" value
  let LLVMName = "Other";
}

def i1      : VTInt<1,   2>;  // One bit boolean value
def i2      : VTInt<2,   3>;  // 2-bit integer value
def i4      : VTInt<4,   4>;  // 4-bit integer value
def i8      : VTInt<8,   5>;  // 8-bit integer value
def i16     : VTInt<16,  6>;  // 16-bit integer value
def i32     : VTInt<32,  7>;  // 32-bit integer value
def i64     : VTInt<64,  8>;  // 64-bit integer value
def i128    : VTInt<128, 9>;  // 128-bit integer value

def bf16    : VTFP<16,  10>;  // 16-bit brain floating point value
def f16     : VTFP<16,  11>;  // 16-bit floating point value
def f32     : VTFP<32,  12>;  // 32-bit floating point value
def f64     : VTFP<64,  13>;  // 64-bit floating point value
def f80     : VTFP<80,  14>;  // 80-bit floating point value
def f128    : VTFP<128, 15>;  // 128-bit floating point value
def ppcf128 : VTFP<128, 16>;  // PPC 128-bit floating point value

def v1i1    : VTVec<1,    i1, 17>;  //    1 x i1 vector value
def v2i1    : VTVec<2,    i1, 18>;  //    2 x i1 vector value
def v3i1    : VTVec<3,    i1, 19>;  //    3 x i1 vector value
def v4i1    : VTVec<4,    i1, 20>;  //    4 x i1 vector value
def v8i1    : VTVec<8,    i1, 21>;  //    8 x i1 vector value
def v16i1   : VTVec<16,   i1, 22>;  //   16 x i1 vector value
def v32i1   : VTVec<32,   i1, 23>;  //   32 x i1 vector value
def v64i1   : VTVec<64,   i1, 24>;  //   64 x i1 vector value
def v128i1  : VTVec<128,  i1, 25>;  //  128 x i1 vector value
def v256i1  : VTVec<256,  i1, 26>;  //  256 x i1 vector value
def v512i1  : VTVec<512,  i1, 27>;  //  512 x i1 vector value
def v1024i1 : VTVec<1024, i1, 28>;  // 1024 x i1 vector value
def v2048i1 : VTVec<2048, i1, 29>;  // 2048 x i1 vector value
def v4096i1 : VTVec<4096, i1, 30>;  // 4096 x i1 vector value

def v128i2  : VTVec<128,  i2, 31>;   //  128 x i2 vector value
def v256i2  : VTVec<256,  i2, 32>;   //  256 x i2 vector value

def v64i4   : VTVec<64,   i4, 33>;   //   64 x i4 vector value
def v128i4  : VTVec<128,  i4, 34>;   //  128 x i4 vector value

def v1i8    : VTVec<1,    i8, 35>;  //    1 x i8 vector value
def v2i8    : VTVec<2,    i8, 36>;  //    2 x i8 vector value
def v3i8    : VTVec<3,    i8, 37>;  //    3 x i8 vector value
def v4i8    : VTVec<4,    i8, 38>;  //    4 x i8 vector value
def v8i8    : VTVec<8,    i8, 39>;  //    8 x i8 vector value
def v16i8   : VTVec<16,   i8, 40>;  //   16 x i8 vector value
def v32i8   : VTVec<32,   i8, 41>;  //   32 x i8 vector value
def v64i8   : VTVec<64,   i8, 42>;  //   64 x i8 vector value
def v128i8  : VTVec<128,  i8, 43>;  //  128 x i8 vector value
def v256i8  : VTVec<256,  i8, 44>;  //  256 x i8 vector value
def v512i8  : VTVec<512,  i8, 45>;  //  512 x i8 vector value
def v1024i8 : VTVec<1024, i8, 46>;  // 1024 x i8 vector value

def v1i16    : VTVec<1,    i16, 47>;  //    1 x i16 vector value
def v2i16    : VTVec<2,    i16, 48>;  //    2 x i16 vector value
def v3i16    : VTVec<3,    i16, 49>;  //    3 x i16 vector value
def v4i16    : VTVec<4,    i16, 50>;  //    4 x i16 vector value
def v8i16    : VTVec<8,    i16, 51>;  //    8 x i16 vector value
def v16i16   : VTVec<16,   i16, 52>;  //   16 x i16 vector value
def v32i16   : VTVec<32,   i16, 53>;  //   32 x i16 vector value
def v64i16   : VTVec<64,   i16, 54>;  //   64 x i16 vector value
def v128i16  : VTVec<128,  i16, 55>;  //  128 x i16 vector value
def v256i16  : VTVec<256,  i16, 56>;  //  256 x i16 vector value
def v512i16  : VTVec<512,  i16, 57>;  //  512 x i16 vector value
def v4096i16 : VTVec<4096, i16, 58>;  // 4096 x i16 vector value

def v1i32    : VTVec<1,    i32, 59>;  //    1 x i32 vector value
def v2i32    : VTVec<2,    i32, 60>;  //    2 x i32 vector value
def v3i32    : VTVec<3,    i32, 61>;  //    3 x i32 vector value
def v4i32    : VTVec<4,    i32, 62>;  //    4 x i32 vector value
def v5i32    : VTVec<5,    i32, 63>;  //    5 x i32 vector value
def v6i32    : VTVec<6,    i32, 64>;  //    6 x f32 vector value
def v7i32    : VTVec<7,    i32, 65>;  //    7 x f32 vector value
def v8i32    : VTVec<8,    i32, 66>;  //    8 x i32 vector value
def v9i32    : VTVec<9,    i32, 67>;  //    9 x i32 vector value
def v10i32   : VTVec<10,   i32, 68>;  //   10 x i32 vector value
def v11i32   : VTVec<11,   i32, 69>;  //   11 x i32 vector value
def v12i32   : VTVec<12,   i32, 70>;  //   12 x i32 vector value
def v16i32   : VTVec<16,   i32, 71>;  //   16 x i32 vector value
def v32i32   : VTVec<32,   i32, 72>;  //   32 x i32 vector value
def v64i32   : VTVec<64,   i32, 73>;  //   64 x i32 vector value
def v128i32  : VTVec<128,  i32, 74>;  //  128 x i32 vector value
def v256i32  : VTVec<256,  i32, 75>;  //  256 x i32 vector value
def v512i32  : VTVec<512,  i32, 76>;  //  512 x i32 vector value
def v1024i32 : VTVec<1024, i32, 77>;  // 1024 x i32 vector value
def v2048i32 : VTVec<2048, i32, 78>;  // 2048 x i32 vector value
def v4096i32 : VTVec<4096, i32, 79>;  // 4096 x i32 vector value

def v1i64   : VTVec<1,   i64, 80>;  //   1 x i64 vector value
def v2i64   : VTVec<2,   i64, 81>;  //   2 x i64 vector value
def v3i64   : VTVec<3,   i64, 82>;  //   3 x i64 vector value
def v4i64   : VTVec<4,   i64, 83>;  //   4 x i64 vector value
def v8i64   : VTVec<8,   i64, 84>;  //   8 x i64 vector value
def v16i64  : VTVec<16,  i64, 85>;  //  16 x i64 vector value
def v32i64  : VTVec<32,  i64, 86>;  //  32 x i64 vector value
def v64i64  : VTVec<64,  i64, 87>;  //  64 x i64 vector value
def v128i64 : VTVec<128, i64, 88>;  // 128 x i64 vector value
def v256i64 : VTVec<256, i64, 89>;  // 256 x i64 vector value

def v1i128  : VTVec<1,  i128, 90>;  //  1 x i128 vector value

def v1f16    : VTVec<1,    f16,  91>;  //    1 x f16 vector value
def v2f16    : VTVec<2,    f16,  92>;  //    2 x f16 vector value
def v3f16    : VTVec<3,    f16,  93>;  //    3 x f16 vector value
def v4f16    : VTVec<4,    f16,  94>;  //    4 x f16 vector value
def v8f16    : VTVec<8,    f16,  95>;  //    8 x f16 vector value
def v16f16   : VTVec<16,   f16,  96>;  //   16 x f16 vector value
def v32f16   : VTVec<32,   f16,  97>;  //   32 x f16 vector value
def v64f16   : VTVec<64,   f16,  98>;  //   64 x f16 vector value
def v128f16  : VTVec<128,  f16,  99>;  //  128 x f16 vector value
def v256f16  : VTVec<256,  f16, 100>;  //  256 x f16 vector value
def v512f16  : VTVec<512,  f16, 101>;  //  512 x f16 vector value
def v4096f16 : VTVec<4096, f16, 102>;  // 4096 x f16 vector value

def v1bf16    : VTVec<1,    bf16, 103>;  //    1 x bf16 vector value
def v2bf16    : VTVec<2,    bf16, 104>;  //    2 x bf16 vector value
def v3bf16    : VTVec<3,    bf16, 105>;  //    3 x bf16 vector value
def v4bf16    : VTVec<4,    bf16, 106>;  //    4 x bf16 vector value
def v8bf16    : VTVec<8,    bf16, 107>;  //    8 x bf16 vector value
def v16bf16   : VTVec<16,   bf16, 108>;  //   16 x bf16 vector value
def v32bf16   : VTVec<32,   bf16, 109>;  //   32 x bf16 vector value
def v64bf16   : VTVec<64,   bf16, 110>;  //   64 x bf16 vector value
def v128bf16  : VTVec<128,  bf16, 111>;  //  128 x bf16 vector value
def v4096bf16 : VTVec<4096, bf16, 112>;  // 4096 x bf16 vector value

def v1f32    : VTVec<1,    f32, 113>;  //    1 x f32 vector value
def v2f32    : VTVec<2,    f32, 114>;  //    2 x f32 vector value
def v3f32    : VTVec<3,    f32, 115>;  //    3 x f32 vector value
def v4f32    : VTVec<4,    f32, 116>;  //    4 x f32 vector value
def v5f32    : VTVec<5,    f32, 117>;  //    5 x f32 vector value
def v6f32    : VTVec<6,    f32, 118>;  //    6 x f32 vector value
def v7f32    : VTVec<7,    f32, 119>;  //    7 x f32 vector value
def v8f32    : VTVec<8,    f32, 120>;  //    8 x f32 vector value
def v9f32    : VTVec<9,    f32, 121>;  //    9 x f32 vector value
def v10f32   : VTVec<10,   f32, 122>;  //   10 x f32 vector value
def v11f32   : VTVec<11,   f32, 123>;  //   11 x f32 vector value
def v12f32   : VTVec<12,   f32, 124>;  //   12 x f32 vector value
def v16f32   : VTVec<16,   f32, 125>;  //   16 x f32 vector value
def v32f32   : VTVec<32,   f32, 126>;  //   32 x f32 vector value
def v64f32   : VTVec<64,   f32, 127>;  //   64 x f32 vector value
def v128f32  : VTVec<128,  f32, 128>;  //  128 x f32 vector value
def v256f32  : VTVec<256,  f32, 129>;  //  256 x f32 vector value
def v512f32  : VTVec<512,  f32, 130>;  //  512 x f32 vector value
def v1024f32 : VTVec<1024, f32, 131>;  // 1024 x f32 vector value
def v2048f32 : VTVec<2048, f32, 132>;  // 2048 x f32 vector value

def v1f64    : VTVec<1,    f64, 133>;  //    1 x f64 vector value
def v2f64    : VTVec<2,    f64, 134>;  //    2 x f64 vector value
def v3f64    : VTVec<3,    f64, 135>;  //    3 x f64 vector value
def v4f64    : VTVec<4,    f64, 136>;  //    4 x f64 vector value
def v8f64    : VTVec<8,    f64, 137>;  //    8 x f64 vector value
def v16f64   : VTVec<16,   f64, 138>;  //   16 x f64 vector value
def v32f64   : VTVec<32,   f64, 139>;  //   32 x f64 vector value
def v64f64   : VTVec<64,   f64, 140>;  //   64 x f64 vector value
def v128f64  : VTVec<128,  f64, 141>;  //  128 x f64 vector value
def v256f64  : VTVec<256,  f64, 142>;  //  256 x f64 vector value

def nxv1i1  : VTScalableVec<1,  i1, 143>;  // n x  1 x i1  vector value
def nxv2i1  : VTScalableVec<2,  i1, 144>;  // n x  2 x i1  vector value
def nxv4i1  : VTScalableVec<4,  i1, 145>;  // n x  4 x i1  vector value
def nxv8i1  : VTScalableVec<8,  i1, 146>;  // n x  8 x i1  vector value
def nxv16i1 : VTScalableVec<16, i1, 147>;  // n x 16 x i1  vector value
def nxv32i1 : VTScalableVec<32, i1, 148>;  // n x 32 x i1  vector value
def nxv64i1 : VTScalableVec<64, i1, 149>;  // n x 64 x i1  vector value

def nxv1i8  : VTScalableVec<1,  i8, 150>;  // n x  1 x i8  vector value
def nxv2i8  : VTScalableVec<2,  i8, 151>;  // n x  2 x i8  vector value
def nxv4i8  : VTScalableVec<4,  i8, 152>;  // n x  4 x i8  vector value
def nxv8i8  : VTScalableVec<8,  i8, 153>;  // n x  8 x i8  vector value
def nxv16i8 : VTScalableVec<16, i8, 154>;  // n x 16 x i8  vector value
def nxv32i8 : VTScalableVec<32, i8, 155>;  // n x 32 x i8  vector value
def nxv64i8 : VTScalableVec<64, i8, 156>;  // n x 64 x i8  vector value

def nxv1i16  : VTScalableVec<1,  i16, 157>;  // n x  1 x i16 vector value
def nxv2i16  : VTScalableVec<2,  i16, 158>;  // n x  2 x i16 vector value
def nxv4i16  : VTScalableVec<4,  i16, 159>;  // n x  4 x i16 vector value
def nxv8i16  : VTScalableVec<8,  i16, 160>;  // n x  8 x i16 vector value
def nxv16i16 : VTScalableVec<16, i16, 161>;  // n x 16 x i16 vector value
def nxv32i16 : VTScalableVec<32, i16, 162>;  // n x 32 x i16 vector value

def nxv1i32  : VTScalableVec<1,  i32, 163>;  // n x  1 x i32 vector value
def nxv2i32  : VTScalableVec<2,  i32, 164>;  // n x  2 x i32 vector value
def nxv4i32  : VTScalableVec<4,  i32, 165>;  // n x  4 x i32 vector value
def nxv8i32  : VTScalableVec<8,  i32, 166>;  // n x  8 x i32 vector value
def nxv16i32 : VTScalableVec<16, i32, 167>;  // n x 16 x i32 vector value
def nxv32i32 : VTScalableVec<32, i32, 168>;  // n x 32 x i32 vector value

def nxv1i64  : VTScalableVec<1,  i64, 169>;  // n x  1 x i64 vector value
def nxv2i64  : VTScalableVec<2,  i64, 170>;  // n x  2 x i64 vector value
def nxv4i64  : VTScalableVec<4,  i64, 171>;  // n x  4 x i64 vector value
def nxv8i64  : VTScalableVec<8,  i64, 172>;  // n x  8 x i64 vector value
def nxv16i64 : VTScalableVec<16, i64, 173>;  // n x 16 x i64 vector value
def nxv32i64 : VTScalableVec<32, i64, 174>;  // n x 32 x i64 vector value

def nxv1f16  : VTScalableVec<1,  f16, 175>;  // n x  1 x  f16 vector value
def nxv2f16  : VTScalableVec<2,  f16, 176>;  // n x  2 x  f16 vector value
def nxv4f16  : VTScalableVec<4,  f16, 177>;  // n x  4 x  f16 vector value
def nxv8f16  : VTScalableVec<8,  f16, 178>;  // n x  8 x  f16 vector value
def nxv16f16 : VTScalableVec<16, f16, 179>;  // n x 16 x  f16 vector value
def nxv32f16 : VTScalableVec<32, f16, 180>;  // n x 32 x  f16 vector value

def nxv1bf16  : VTScalableVec<1,  bf16, 181>;  // n x  1 x bf16 vector value
def nxv2bf16  : VTScalableVec<2,  bf16, 182>;  // n x  2 x bf16 vector value
def nxv4bf16  : VTScalableVec<4,  bf16, 183>;  // n x  4 x bf16 vector value
def nxv8bf16  : VTScalableVec<8,  bf16, 184>;  // n x  8 x bf16 vector value
def nxv16bf16 : VTScalableVec<16, bf16, 185>;  // n x 16 x bf16 vector value
def nxv32bf16 : VTScalableVec<32, bf16, 186>;  // n x 32 x bf16 vector value

def nxv1f32  : VTScalableVec<1,  f32, 187>;  // n x  1 x  f32 vector value
def nxv2f32  : VTScalableVec<2,  f32, 188>;  // n x  2 x  f32 vector value
def nxv4f32  : VTScalableVec<4,  f32, 189>;  // n x  4 x  f32 vector value
def nxv8f32  : VTScalableVec<8,  f32, 190>;  // n x  8 x  f32 vector value
def nxv16f32 : VTScalableVec<16, f32, 191>;  // n x 16 x  f32 vector value

def nxv1f64  : VTScalableVec<1,  f64, 192>;  // n x  1 x  f64 vector value
def nxv2f64  : VTScalableVec<2,  f64, 193>;  // n x  2 x  f64 vector value
def nxv4f64  : VTScalableVec<4,  f64, 194>;  // n x  4 x  f64 vector value
def nxv8f64  : VTScalableVec<8,  f64, 195>;  // n x  8 x  f64 vector value

// Sz = NF * MinNumElts * 8(bits)
def riscv_nxv1i8x2   : VTVecTup<16,  2, i8, 196>;  // RISCV vector tuple(min_num_elts=1,  nf=2)
def riscv_nxv1i8x3   : VTVecTup<24,  3, i8, 197>;  // RISCV vector tuple(min_num_elts=1,  nf=3)
def riscv_nxv1i8x4   : VTVecTup<32,  4, i8, 198>;  // RISCV vector tuple(min_num_elts=1,  nf=4)
def riscv_nxv1i8x5   : VTVecTup<40,  5, i8, 199>;  // RISCV vector tuple(min_num_elts=1,  nf=5)
def riscv_nxv1i8x6   : VTVecTup<48,  6, i8, 200>;  // RISCV vector tuple(min_num_elts=1,  nf=6)
def riscv_nxv1i8x7   : VTVecTup<56,  7, i8, 201>;  // RISCV vector tuple(min_num_elts=1,  nf=7)
def riscv_nxv1i8x8   : VTVecTup<64,  8, i8, 202>;  // RISCV vector tuple(min_num_elts=1,  nf=8)
def riscv_nxv2i8x2   : VTVecTup<32,  2, i8, 203>;  // RISCV vector tuple(min_num_elts=2,  nf=2)
def riscv_nxv2i8x3   : VTVecTup<48,  3, i8, 204>;  // RISCV vector tuple(min_num_elts=2,  nf=3)
def riscv_nxv2i8x4   : VTVecTup<64,  4, i8, 205>;  // RISCV vector tuple(min_num_elts=2,  nf=4)
def riscv_nxv2i8x5   : VTVecTup<80,  5, i8, 206>;  // RISCV vector tuple(min_num_elts=2,  nf=5)
def riscv_nxv2i8x6   : VTVecTup<96,  6, i8, 207>;  // RISCV vector tuple(min_num_elts=2,  nf=6)
def riscv_nxv2i8x7   : VTVecTup<112, 7, i8, 208>;  // RISCV vector tuple(min_num_elts=2,  nf=7)
def riscv_nxv2i8x8   : VTVecTup<128, 8, i8, 209>;  // RISCV vector tuple(min_num_elts=2,  nf=8)
def riscv_nxv4i8x2   : VTVecTup<64,  2, i8, 210>;  // RISCV vector tuple(min_num_elts=4,  nf=2)
def riscv_nxv4i8x3   : VTVecTup<96,  3, i8, 211>;  // RISCV vector tuple(min_num_elts=4,  nf=3)
def riscv_nxv4i8x4   : VTVecTup<128, 4, i8, 212>;  // RISCV vector tuple(min_num_elts=4,  nf=4)
def riscv_nxv4i8x5   : VTVecTup<160, 5, i8, 213>;  // RISCV vector tuple(min_num_elts=4,  nf=5)
def riscv_nxv4i8x6   : VTVecTup<192, 6, i8, 214>;  // RISCV vector tuple(min_num_elts=4,  nf=6)
def riscv_nxv4i8x7   : VTVecTup<224, 7, i8, 215>;  // RISCV vector tuple(min_num_elts=4,  nf=7)
def riscv_nxv4i8x8   : VTVecTup<256, 8, i8, 216>;  // RISCV vector tuple(min_num_elts=4,  nf=8)
def riscv_nxv8i8x2   : VTVecTup<128, 2, i8, 217>;  // RISCV vector tuple(min_num_elts=8,  nf=2)
def riscv_nxv8i8x3   : VTVecTup<192, 3, i8, 218>;  // RISCV vector tuple(min_num_elts=8,  nf=3)
def riscv_nxv8i8x4   : VTVecTup<256, 4, i8, 219>;  // RISCV vector tuple(min_num_elts=8,  nf=4)
def riscv_nxv8i8x5   : VTVecTup<320, 5, i8, 220>;  // RISCV vector tuple(min_num_elts=8,  nf=5)
def riscv_nxv8i8x6   : VTVecTup<384, 6, i8, 221>;  // RISCV vector tuple(min_num_elts=8,  nf=6)
def riscv_nxv8i8x7   : VTVecTup<448, 7, i8, 222>;  // RISCV vector tuple(min_num_elts=8,  nf=7)
def riscv_nxv8i8x8   : VTVecTup<512, 8, i8, 223>;  // RISCV vector tuple(min_num_elts=8,  nf=8)
def riscv_nxv16i8x2  : VTVecTup<256, 2, i8, 224>;  // RISCV vector tuple(min_num_elts=16, nf=2)
def riscv_nxv16i8x3  : VTVecTup<384, 3, i8, 225>;  // RISCV vector tuple(min_num_elts=16, nf=3)
def riscv_nxv16i8x4  : VTVecTup<512, 4, i8, 226>;  // RISCV vector tuple(min_num_elts=16, nf=4)
def riscv_nxv32i8x2  : VTVecTup<512, 2, i8, 227>;  // RISCV vector tuple(min_num_elts=32, nf=2)

def x86mmx    : ValueType<64,   228>;  // X86 MMX value
def Glue      : ValueType<0,    229>;  // Pre-RA sched glue
def isVoid    : ValueType<0,    230>;  // Produces no value
def untyped   : ValueType<8,    231> { // Produces an untyped value
  let LLVMName = "Untyped";
}
def funcref   : ValueType<0,    232>;  // WebAssembly's funcref type
def externref : ValueType<0,    233>;  // WebAssembly's externref type
def exnref    : ValueType<0,    234>;  // WebAssembly's exnref type
def x86amx    : ValueType<8192, 235>;  // X86 AMX value
def i64x8     : ValueType<512,  236>;  // 8 Consecutive GPRs (AArch64)
def aarch64svcount
              : ValueType<16,  237>;  // AArch64 predicate-as-counter
def spirvbuiltin : ValueType<0, 238>; // SPIR-V's builtin type
// AMDGPU buffer fat pointer, buffer rsrc + offset, rewritten before MIR translation.
// FIXME: Remove this and the getPointerType() override if MVT::i160 is added.
def amdgpuBufferFatPointer : ValueType<160, 239>;
// AMDGPU buffer strided pointer, buffer rsrc + index + offset, doesn't reach MIR.
// FIXME: Remove this and the getPointerType() override if MVT::i82 is added.
def amdgpuBufferStridedPointer : ValueType<192, 240>;

def aarch64mfp8 : ValueType<8,  241>;  // 8-bit value in FPR (AArch64)

let isNormalValueType = false in {
def token      : ValueType<0, 504>;  // TokenTy
def MetadataVT : ValueType<0, 505> { // Metadata
  let LLVMName = "Metadata";
}

// Pseudo valuetype to represent "pointer to any address space"
// Should only be used in TableGen.
def pAny       : VTAny<506>;

// Pseudo valuetype to represent "vector of any size"
// Should only be used in TableGen.
def vAny       : VTAny<507>;

// Pseudo valuetype to represent "float of any format"
// Should only be used in TableGen.
def fAny       : VTAny<508>;

// Pseudo valuetype to represent "integer of any bit width"
// Should only be used in TableGen.
def iAny       : VTAny<509>;

// Pseudo valuetype mapped to the current pointer size.
// Should only be used in TableGen.
def iPTR       : ValueType<0, 510>;

// Pseudo valuetype to represent "any type of any size".
// Should only be used in TableGen.
def Any        : VTAny<511>;

} // isNormalValueType = false

} // end defset ValueTypes

/// This class is for targets that want to use pointer types in patterns
/// with the GlobalISelEmitter.  Targets must define their own pointer
/// derived from this class.  The scalar argument should be an
/// integer type with the same bit size as the pointer.
/// e.g. def p0 : PtrValueType <i64, 0>;

class PtrValueType <ValueType scalar, int addrspace> :
    ValueType<scalar.Size, scalar.Value> {
  int AddrSpace = addrspace;
}
