package dinocpu.components

import chisel3._
import chisel3.util._

/*
 The radix4 multiplier
 Input: inputx , reg1
 Input: inputy,  reg2
 Input: start, start to run value into Mp, Md
 Output: result, the final result
 Output: done, the multiplier calculation done


*/
class radix4mul extends Module{
    val io = IO(new Bundle {
        val inputx = Input(UInt(16.W))
        val inputy = Input(UInt(16.W))
        val start  = Input(Bool())        // start run ff
        val result = Output(UInt(32.W))
        val done   = Output(Bool())
    })
    val product = Reg(UInt(32.W))
    val Mp = Reg(UInt(3.W))
    val ExtInputx = Reg(UInt(32.W))        // store sign extended inputx(Md)
    val acc = Reg(UInt(32.W))
    val shiftacc = Reg(UInt(32.W))
    val i = Reg(UInt(16.W))
    val j = Reg(UInt(16.W))
    val k = Reg(UInt(16.W))
    val flag = Reg(Bool())                 // set flag
    val temp = Reg(UInt(1.W))
    val norx = Wire(UInt(16.W))


    when(io.start){
      io.result   := 0.U         // defaut to output result 0
      io.done     := false.B         // default to done  0
      product  := 0.U
      acc      := 0.U
      shiftacc := 0.U
      i        := 0.U
      j        := 0.U
      flag     := 0.U
      ExtInputx := 0.U
      norx      := ~io.inputx + 1.U
    }

    when(!flag){
      Mp:= Cat(io.inputy(1), io.inputy(0), 0.U)

    }
    flag := true.B
   when(!io.done){
    switch(Mp){
      is("b000".U){          // 0
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b111".U){          // 0
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b001".U){         // 1x Multiplicand
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
              // acc = acc + Md,
              ExtInputx := Cat(Fill(16, io.inputx(15)), io.inputx)

              when(i === 1.U){
                  acc := ExtInputx
              }
              .otherwise{
                  //temp := ExtInputx(31)
                  j := i - 1.U
                  j := j << 1
                  shiftacc := ExtInputx << j           // left shift Inputx j bits
                //  shiftacc := Cat(temp, shiftacc(30,0))
                  acc := acc + shiftacc
              }
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b010".U){         // 1x Multiplicand
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
              // acc = acc + Md,
              ExtInputx := Cat(Fill(16, io.inputx(15)), io.inputx)

              when(i === 1.U){
                  acc := ExtInputx
              }
              .otherwise{
                  //temp := ExtInputx(31)
                  j := i - 1.U
                  j := j << 1
                  shiftacc := ExtInputx << j           // left shift Inputx j bits
                //  shiftacc := Cat(temp, shiftacc(30,0))
                  acc := acc + shiftacc
              }
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b011".U){                 // 2x Multiplicand
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
              ExtInputx := Cat(Fill(15, io.inputx(15)), io.inputx, 0.U) // dauble and extend inputx(Md)
              when(i === 1.U){
                   acc := ExtInputx
              }.otherwise{
                //  emp := acc(32)
                  j := i - 1.U
                  j := j << 1
                  shiftacc := ExtInputx << j
                //  shiftacc := Cat(temp, shiftacc(31,0))
                  acc := acc + shiftacc
              }
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b100".U){
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
              ExtInputx := Cat(Fill(15, norx(15)), norx, 0.U)
              when(i === 1.U){
                  acc := ExtInputx
              }otherwise{
                  //emp := acc(32)
                  j := i - 1.U
                  j := j << 1
                  shiftacc := ExtInputx << j
                //  shiftacc := Cat(temp, shiftacc(31,0))
                  acc := acc + shiftacc
              }
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b101".U){
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
              ExtInputx := Cat(Fill(16, norx(15)), norx)
              when(i === 1.U){
                  acc := ExtInputx
              }.otherwise{
                  //emp := acc(32)
                  j := i - 1.U
                  j := j << 1
                  shiftacc := ExtInputx << j
                  //shiftacc := Cat(temp, shiftacc(31,0))
                  acc := acc + shiftacc
              }
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }
      is("b110".U){
          when(i < 8.U){
              i := i + 1.U
              k := i<<1
              Mp := Cat(io.inputy(k + 1.U), io.inputy(k), io.inputy(k - 1.U))
              ExtInputx := Cat(Fill(16, norx(15)), norx)
              when(i === 1.U){
                  acc := ExtInputx
              }.otherwise{
                  //emp := acc(32)
                  j := i - 1.U
                  j := j << 1
                  shiftacc := ExtInputx << j
                  //shiftacc := Cat(temp, shiftacc(31,0))
                  acc := acc + shiftacc
              }
          }.otherwise{
            io.result := acc
            io.done := true.B
          }
      }


    }






    }





}
