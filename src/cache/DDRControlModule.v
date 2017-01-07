module DDRControlModule(input clk, input reset,
    input  io_init_calib_complete,
    input  io_mig_data_valid,
    input  io_mig_rdy,
    input  io_mig_wdf_rdy,
    input [127:0] io_data_from_mig,
    input  io_ram_en,
    input  io_ram_write,
    input [29:0] io_ram_addr,
    input [255:0] io_data_to_ram,
    output[2:0] io_cmd_to_mig,
    output io_app_en,
    output io_ram_rdy,
    output io_app_wdf_wren,
    output io_app_wdf_end,
    output[26:0] io_addr_to_mig,
    output[127:0] io_data_to_mig,
    output[255:0] io_data_to_cpu,
    output[4:0] io_state_to_cpu
);

  reg [4:0] state;
  wire[4:0] T283;
  wire[4:0] T0;
  wire[4:0] T1;
  wire[4:0] T2;
  wire[4:0] T3;
  wire[4:0] T4;
  wire[4:0] T5;
  wire[4:0] T6;
  wire[4:0] T7;
  wire[4:0] T8;
  wire[4:0] T9;
  wire[4:0] T10;
  wire[4:0] T11;
  wire[4:0] T12;
  wire[4:0] T13;
  wire[4:0] T14;
  wire[4:0] T15;
  wire[4:0] T16;
  wire[4:0] T17;
  wire[4:0] T18;
  wire[4:0] T19;
  wire[4:0] T20;
  wire[4:0] T21;
  wire[4:0] T22;
  wire[4:0] T23;
  wire[4:0] T24;
  wire[4:0] T25;
  wire[4:0] T26;
  wire[4:0] T27;
  wire[4:0] T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire T33;
  wire not_move;
  wire T34;
  wire T35;
  reg  ram_write_old;
  wire T284;
  wire T36;
  wire T37;
  wire T38;
  wire[22:0] T39;
  wire[22:0] T285;
  reg [21:0] ram_addr_old;
  wire[21:0] T286;
  wire[22:0] T287;
  wire[22:0] T40;
  wire[22:0] T288;
  wire[22:0] T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  reg [5:0] counter;
  wire[5:0] T289;
  wire[5:0] T57;
  wire[5:0] T58;
  wire[5:0] T59;
  wire[5:0] T60;
  wire[5:0] T61;
  wire[5:0] T62;
  wire[5:0] T63;
  wire[5:0] T64;
  wire[5:0] T65;
  wire[5:0] T66;
  wire[5:0] T67;
  wire[5:0] T68;
  wire[5:0] T69;
  wire[5:0] T70;
  wire[5:0] T71;
  wire[5:0] T72;
  wire[5:0] T73;
  wire[5:0] T74;
  wire[5:0] T75;
  wire[5:0] T76;
  wire[5:0] T77;
  wire[5:0] T78;
  wire[5:0] T79;
  wire[5:0] T80;
  wire[5:0] T81;
  wire[5:0] T82;
  wire[5:0] T83;
  wire[5:0] T84;
  wire[5:0] T85;
  wire[5:0] T86;
  wire[5:0] T87;
  wire[5:0] T88;
  wire[5:0] T89;
  wire[5:0] T90;
  wire[5:0] T91;
  wire[5:0] T92;
  wire[5:0] T93;
  wire[5:0] T94;
  wire T95;
  wire T96;
  wire[5:0] T97;
  wire T98;
  wire T99;
  wire[5:0] T100;
  wire T101;
  wire T102;
  wire[5:0] T103;
  wire T104;
  wire T105;
  wire[5:0] T106;
  wire T107;
  wire T108;
  wire[5:0] T109;
  wire T110;
  wire T111;
  wire[5:0] T112;
  wire T113;
  wire T114;
  wire[5:0] T115;
  wire T116;
  wire T117;
  wire[5:0] T118;
  wire T119;
  wire T120;
  wire[5:0] T121;
  wire T122;
  wire T123;
  wire[5:0] T124;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire T129;
  wire T130;
  wire T131;
  wire T132;
  wire T133;
  wire T134;
  wire T135;
  wire T136;
  wire T137;
  wire T138;
  wire[127:0] T139;
  wire T140;
  wire T141;
  wire T142;
  wire T143;
  wire T144;
  wire T145;
  wire T146;
  wire T147;
  wire T148;
  wire T149;
  wire T150;
  wire T151;
  wire T152;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire[127:0] T161;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  wire T170;
  wire T171;
  wire T172;
  wire T173;
  wire T174;
  wire T175;
  wire T176;
  wire T177;
  wire T178;
  wire T179;
  wire T180;
  wire T181;
  wire T182;
  wire T183;
  wire[127:0] T184;
  reg [255:0] buffer_old;
  wire[255:0] T290;
  wire[255:0] T185;
  wire[255:0] T186;
  wire[255:0] T187;
  wire[255:0] T291;
  wire[127:0] T188;
  wire[127:0] T189;
  wire[255:0] T190;
  wire[255:0] T292;
  wire[128:0] T191;
  wire[128:0] T192;
  wire[126:0] T293;
  wire T294;
  wire[255:0] T193;
  wire[255:0] T295;
  wire[127:0] T194;
  wire[127:0] T195;
  wire[255:0] T196;
  wire[255:0] T296;
  wire[128:0] T197;
  wire[128:0] T198;
  wire[126:0] T297;
  wire T298;
  wire T199;
  wire T200;
  wire T201;
  wire T202;
  wire T203;
  wire T204;
  wire T205;
  wire T206;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  wire T214;
  wire T215;
  wire T216;
  wire T217;
  wire T218;
  wire T219;
  wire T220;
  wire[127:0] T221;
  wire T222;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  reg [255:0] buffer;
  wire[255:0] T299;
  wire[256:0] T300;
  wire[256:0] T228;
  wire[256:0] T301;
  wire[255:0] T229;
  wire[255:0] T230;
  wire[255:0] T302;
  wire[127:0] T231;
  wire[127:0] T232;
  wire[255:0] T233;
  wire[255:0] T303;
  wire[128:0] T234;
  wire[128:0] T235;
  wire[126:0] T304;
  wire T305;
  wire[256:0] T236;
  wire[256:0] T306;
  wire[255:0] T237;
  wire[127:0] T238;
  wire[256:0] T239;
  wire[256:0] T240;
  wire[256:0] T241;
  wire[256:0] T307;
  wire[127:0] T242;
  wire[127:0] T243;
  wire[127:0] T244;
  wire[127:0] T245;
  wire[26:0] T308;
  wire[27:0] T246;
  wire[27:0] T247;
  wire[27:0] T248;
  wire[27:0] T249;
  wire[27:0] T250;
  wire[27:0] T251;
  wire[27:0] T252;
  wire[27:0] T253;
  wire[27:0] T254;
  wire[22:0] T255;
  wire[27:0] T256;
  wire[22:0] T257;
  wire[27:0] T258;
  wire[22:0] T259;
  wire[27:0] T260;
  wire[22:0] T261;
  wire[27:0] T262;
  wire[22:0] T263;
  wire[27:0] T264;
  wire[22:0] T265;
  wire[27:0] T266;
  wire[22:0] T267;
  wire[27:0] T268;
  wire[22:0] T269;
  wire T270;
  wire T271;
  wire T272;
  wire T273;
  wire T274;
  wire T275;
  wire T276;
  wire T277;
  wire T278;
  wire T279;
  wire T280;
  wire[2:0] T309;
  wire T281;
  wire T282;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    state = {1{$random}};
    ram_write_old = {1{$random}};
    ram_addr_old = {1{$random}};
    counter = {1{$random}};
    buffer_old = {8{$random}};
    buffer = {8{$random}};
  end
// synthesis translate_on
`endif

  assign io_state_to_cpu = state;
  assign T283 = reset ? 5'h0 : T0;
  assign T0 = T226 ? 5'h0 : T1;
  assign T1 = T222 ? 5'hf : T2;
  assign T2 = T219 ? 5'hd : T3;
  assign T3 = T216 ? 5'h11 : T4;
  assign T4 = T213 ? 5'h10 : T5;
  assign T5 = T209 ? 5'hd : T6;
  assign T6 = T206 ? 5'hf : T7;
  assign T7 = T203 ? 5'he : T8;
  assign T8 = T199 ? 5'hb : T9;
  assign T9 = T182 ? 5'h9 : T10;
  assign T10 = T179 ? 5'hd : T11;
  assign T11 = T176 ? 5'hc : T12;
  assign T12 = T172 ? 5'h9 : T13;
  assign T13 = T169 ? 5'hb : T14;
  assign T14 = T166 ? 5'ha : T15;
  assign T15 = T162 ? 5'h7 : T16;
  assign T16 = T159 ? 5'h3 : T17;
  assign T17 = T154 ? 5'h11 : T18;
  assign T18 = T151 ? 5'h8 : T19;
  assign T19 = T148 ? 5'h7 : T20;
  assign T20 = T144 ? 5'h4 : T21;
  assign T21 = T140 ? 5'h5 : T22;
  assign T22 = T137 ? 5'h1 : T23;
  assign T23 = T132 ? 5'h3 : T24;
  assign T24 = T129 ? 5'h6 : T25;
  assign T25 = T54 ? 5'h5 : T26;
  assign T26 = T50 ? 5'h2 : T27;
  assign T27 = T48 ? 5'h1 : T28;
  assign T28 = T29 ? 5'h9 : state;
  assign T29 = T32 & T30;
  assign T30 = io_ram_en & T31;
  assign T31 = ~ io_ram_write;
  assign T32 = T46 & T33;
  assign T33 = ~ not_move;
  assign not_move = T43 | T34;
  assign T34 = T37 & T35;
  assign T35 = ram_write_old == io_ram_write;
  assign T284 = reset ? 1'h0 : T36;
  assign T36 = T226 ? io_ram_write : ram_write_old;
  assign T37 = T42 & T38;
  assign T38 = T285 == T39;
  assign T39 = io_ram_addr[25:3];
  assign T285 = {1'h0, ram_addr_old};
  assign T286 = T287[21:0];
  assign T287 = reset ? 23'h0 : T40;
  assign T40 = T226 ? T41 : T288;
  assign T288 = {1'h0, ram_addr_old};
  assign T41 = io_ram_addr[25:3];
  assign T42 = state == 5'h0;
  assign T43 = T45 & T44;
  assign T44 = io_ram_en == 1'h0;
  assign T45 = state == 5'h0;
  assign T46 = io_init_calib_complete & T47;
  assign T47 = state == 5'h0;
  assign T48 = T32 & T49;
  assign T49 = io_ram_en & io_ram_write;
  assign T50 = T52 & T51;
  assign T51 = io_mig_rdy & io_mig_wdf_rdy;
  assign T52 = io_init_calib_complete & T53;
  assign T53 = state == 5'h1;
  assign T54 = T127 & T55;
  assign T55 = io_mig_rdy & T56;
  assign T56 = 6'h3 <= counter;
  assign T289 = reset ? 6'h0 : T57;
  assign T57 = T222 ? 6'h0 : T58;
  assign T58 = T125 ? T124 : T59;
  assign T59 = T213 ? 6'h0 : T60;
  assign T60 = T122 ? T121 : T61;
  assign T61 = T209 ? 6'h0 : T62;
  assign T62 = T206 ? 6'h0 : T63;
  assign T63 = T119 ? T118 : T64;
  assign T64 = T203 ? 6'h0 : T65;
  assign T65 = T116 ? T115 : T66;
  assign T66 = T199 ? 6'h0 : T67;
  assign T67 = T179 ? 6'h0 : T68;
  assign T68 = T113 ? T112 : T69;
  assign T69 = T176 ? 6'h0 : T70;
  assign T70 = T110 ? T109 : T71;
  assign T71 = T172 ? 6'h0 : T72;
  assign T72 = T169 ? 6'h0 : T73;
  assign T73 = T107 ? T106 : T74;
  assign T74 = T166 ? 6'h0 : T75;
  assign T75 = T104 ? T103 : T76;
  assign T76 = T162 ? 6'h0 : T77;
  assign T77 = T154 ? 6'h0 : T78;
  assign T78 = T151 ? 6'h0 : T79;
  assign T79 = T101 ? T100 : T80;
  assign T80 = T148 ? 6'h0 : T81;
  assign T81 = T98 ? T97 : T82;
  assign T82 = T144 ? 6'h0 : T83;
  assign T83 = T140 ? 6'h0 : T84;
  assign T84 = T132 ? 6'h0 : T85;
  assign T85 = T129 ? 6'h0 : T86;
  assign T86 = T95 ? T94 : T87;
  assign T87 = T54 ? 6'h0 : T88;
  assign T88 = T127 ? T93 : T89;
  assign T89 = T50 ? 6'h0 : T90;
  assign T90 = T32 ? 6'h0 : T91;
  assign T91 = io_init_calib_complete ? T92 : counter;
  assign T92 = counter + 6'h1;
  assign T93 = counter + 6'h1;
  assign T94 = counter + 6'h1;
  assign T95 = io_init_calib_complete & T96;
  assign T96 = state == 5'h5;
  assign T97 = counter + 6'h1;
  assign T98 = io_init_calib_complete & T99;
  assign T99 = state == 5'h4;
  assign T100 = counter + 6'h1;
  assign T101 = io_init_calib_complete & T102;
  assign T102 = state == 5'h7;
  assign T103 = counter + 6'h1;
  assign T104 = io_init_calib_complete & T105;
  assign T105 = state == 5'h9;
  assign T106 = counter + 6'h1;
  assign T107 = io_init_calib_complete & T108;
  assign T108 = state == 5'ha;
  assign T109 = counter + 6'h1;
  assign T110 = io_init_calib_complete & T111;
  assign T111 = state == 5'hb;
  assign T112 = counter + 6'h1;
  assign T113 = io_init_calib_complete & T114;
  assign T114 = state == 5'hc;
  assign T115 = counter + 6'h1;
  assign T116 = io_init_calib_complete & T117;
  assign T117 = state == 5'hd;
  assign T118 = counter + 6'h1;
  assign T119 = io_init_calib_complete & T120;
  assign T120 = state == 5'he;
  assign T121 = counter + 6'h1;
  assign T122 = io_init_calib_complete & T123;
  assign T123 = state == 5'hf;
  assign T124 = counter + 6'h1;
  assign T125 = io_init_calib_complete & T126;
  assign T126 = state == 5'h10;
  assign T127 = io_init_calib_complete & T128;
  assign T128 = state == 5'h2;
  assign T129 = T95 & T130;
  assign T130 = io_mig_rdy & T131;
  assign T131 = 6'h1 <= counter;
  assign T132 = T135 & T133;
  assign T133 = io_mig_data_valid & T134;
  assign T134 = 6'h4 <= counter;
  assign T135 = io_init_calib_complete & T136;
  assign T136 = state == 5'h6;
  assign T137 = T132 & T138;
  assign T138 = io_data_from_mig != T139;
  assign T139 = io_data_to_ram[127:0];
  assign T140 = T135 & T141;
  assign T141 = T143 & T142;
  assign T142 = 6'h3c <= counter;
  assign T143 = ~ io_mig_data_valid;
  assign T144 = T146 & T145;
  assign T145 = io_mig_rdy & io_mig_wdf_rdy;
  assign T146 = io_init_calib_complete & T147;
  assign T147 = state == 5'h3;
  assign T148 = T98 & T149;
  assign T149 = io_mig_rdy & T150;
  assign T150 = 6'h3 <= counter;
  assign T151 = T101 & T152;
  assign T152 = io_mig_rdy & T153;
  assign T153 = 6'h1 <= counter;
  assign T154 = T157 & T155;
  assign T155 = io_mig_data_valid & T156;
  assign T156 = 6'h4 <= counter;
  assign T157 = io_init_calib_complete & T158;
  assign T158 = state == 5'h8;
  assign T159 = T154 & T160;
  assign T160 = io_data_from_mig != T161;
  assign T161 = io_data_to_ram[255:128];
  assign T162 = T157 & T163;
  assign T163 = T165 & T164;
  assign T164 = 6'h3c <= counter;
  assign T165 = ~ io_mig_data_valid;
  assign T166 = T104 & T167;
  assign T167 = io_mig_rdy & T168;
  assign T168 = 6'h1 <= counter;
  assign T169 = T107 & T170;
  assign T170 = io_mig_data_valid & T171;
  assign T171 = 6'h4 <= counter;
  assign T172 = T107 & T173;
  assign T173 = T175 & T174;
  assign T174 = 6'h3c <= counter;
  assign T175 = ~ io_mig_data_valid;
  assign T176 = T110 & T177;
  assign T177 = io_mig_rdy & T178;
  assign T178 = 6'h1 <= counter;
  assign T179 = T113 & T180;
  assign T180 = io_mig_data_valid & T181;
  assign T181 = 6'h4 <= counter;
  assign T182 = T179 & T183;
  assign T183 = io_data_from_mig != T184;
  assign T184 = buffer_old[127:0];
  assign T290 = reset ? 256'h0 : T185;
  assign T185 = T206 ? T193 : T186;
  assign T186 = T169 ? T187 : buffer_old;
  assign T187 = T190 | T291;
  assign T291 = {128'h0, T188};
  assign T188 = T189 << 1'h0;
  assign T189 = io_data_from_mig & 128'hffffffffffffffffffffffffffffffff;
  assign T190 = buffer_old & T292;
  assign T292 = {T293, T191};
  assign T191 = ~ T192;
  assign T192 = 129'hffffffffffffffffffffffffffffffff;
  assign T293 = T294 ? 127'h7fffffffffffffffffffffffffffffff : 127'h0;
  assign T294 = T191[128];
  assign T193 = T196 | T295;
  assign T295 = {128'h0, T194};
  assign T194 = T195 << 1'h0;
  assign T195 = io_data_from_mig & 128'hffffffffffffffffffffffffffffffff;
  assign T196 = T186 & T296;
  assign T296 = {T297, T197};
  assign T197 = ~ T198;
  assign T198 = 129'hffffffffffffffffffffffffffffffff;
  assign T297 = T298 ? 127'h7fffffffffffffffffffffffffffffff : 127'h0;
  assign T298 = T197[128];
  assign T199 = T113 & T200;
  assign T200 = T202 & T201;
  assign T201 = 6'h3c <= counter;
  assign T202 = ~ io_mig_data_valid;
  assign T203 = T116 & T204;
  assign T204 = io_mig_rdy & T205;
  assign T205 = 6'h1 <= counter;
  assign T206 = T119 & T207;
  assign T207 = io_mig_data_valid & T208;
  assign T208 = 6'h4 <= counter;
  assign T209 = T119 & T210;
  assign T210 = T212 & T211;
  assign T211 = 6'h3c <= counter;
  assign T212 = ~ io_mig_data_valid;
  assign T213 = T122 & T214;
  assign T214 = io_mig_rdy & T215;
  assign T215 = 6'h1 <= counter;
  assign T216 = T125 & T217;
  assign T217 = io_mig_data_valid & T218;
  assign T218 = 6'h4 <= counter;
  assign T219 = T216 & T220;
  assign T220 = io_data_from_mig != T221;
  assign T221 = buffer_old[127:0];
  assign T222 = T125 & T223;
  assign T223 = T225 & T224;
  assign T224 = 6'h3c <= counter;
  assign T225 = ~ io_mig_data_valid;
  assign T226 = io_init_calib_complete & T227;
  assign T227 = state == 5'h11;
  assign io_data_to_cpu = buffer;
  assign T299 = T300[255:0];
  assign T300 = reset ? 257'h0 : T228;
  assign T228 = T216 ? T236 : T301;
  assign T301 = {1'h0, T229};
  assign T229 = T179 ? T230 : buffer;
  assign T230 = T233 | T302;
  assign T302 = {128'h0, T231};
  assign T231 = T232 << 1'h0;
  assign T232 = io_data_from_mig & 128'hffffffffffffffffffffffffffffffff;
  assign T233 = buffer & T303;
  assign T303 = {T304, T234};
  assign T234 = ~ T235;
  assign T235 = 129'hffffffffffffffffffffffffffffffff;
  assign T304 = T305 ? 127'h7fffffffffffffffffffffffffffffff : 127'h0;
  assign T305 = T234[128];
  assign T236 = T239 | T306;
  assign T306 = {1'h0, T237};
  assign T237 = T238 << 8'h80;
  assign T238 = io_data_from_mig & 128'hffffffffffffffffffffffffffffffff;
  assign T239 = T307 & T240;
  assign T240 = ~ T241;
  assign T241 = 257'hffffffffffffffffffffffffffffffff00000000000000000000000000000000;
  assign T307 = {1'h0, T229};
  assign io_data_to_mig = T242;
  assign T242 = T146 ? T245 : T243;
  assign T243 = T52 ? T244 : 128'h0;
  assign T244 = io_data_to_ram[127:0];
  assign T245 = io_data_to_ram[255:128];
  assign io_addr_to_mig = T308;
  assign T308 = T246[26:0];
  assign T246 = T122 ? T268 : T247;
  assign T247 = T116 ? T266 : T248;
  assign T248 = T110 ? T264 : T249;
  assign T249 = T104 ? T262 : T250;
  assign T250 = T101 ? T260 : T251;
  assign T251 = T146 ? T258 : T252;
  assign T252 = T95 ? T256 : T253;
  assign T253 = T52 ? T254 : 28'h0;
  assign T254 = {T255, 5'h0};
  assign T255 = io_ram_addr[25:3];
  assign T256 = {T257, 5'h0};
  assign T257 = io_ram_addr[25:3];
  assign T258 = {T259, 5'h10};
  assign T259 = io_ram_addr[25:3];
  assign T260 = {T261, 5'h10};
  assign T261 = io_ram_addr[25:3];
  assign T262 = {T263, 5'h0};
  assign T263 = io_ram_addr[25:3];
  assign T264 = {T265, 5'h0};
  assign T265 = io_ram_addr[25:3];
  assign T266 = {T267, 5'h10};
  assign T267 = io_ram_addr[25:3];
  assign T268 = {T269, 5'h10};
  assign T269 = io_ram_addr[25:3];
  assign io_app_wdf_end = T270;
  assign T270 = T146 ? 1'h1 : T52;
  assign io_app_wdf_wren = T271;
  assign T271 = T146 ? 1'h1 : T52;
  assign io_ram_rdy = T272;
  assign T272 = not_move | T273;
  assign T273 = state == 5'h11;
  assign io_app_en = T274;
  assign T274 = T122 ? 1'h1 : T275;
  assign T275 = T116 ? 1'h1 : T276;
  assign T276 = T110 ? 1'h1 : T277;
  assign T277 = T104 ? 1'h1 : T278;
  assign T278 = T101 ? 1'h1 : T279;
  assign T279 = T146 ? 1'h1 : T280;
  assign T280 = T95 ? 1'h1 : T52;
  assign io_cmd_to_mig = T309;
  assign T309 = {2'h0, T281};
  assign T281 = T146 ? 1'h0 : T282;
  assign T282 = T52 == 1'h0;

  always @(posedge clk) begin
    if(reset) begin
      state <= 5'h0;
    end else if(T226) begin
      state <= 5'h0;
    end else if(T222) begin
      state <= 5'hf;
    end else if(T219) begin
      state <= 5'hd;
    end else if(T216) begin
      state <= 5'h11;
    end else if(T213) begin
      state <= 5'h10;
    end else if(T209) begin
      state <= 5'hd;
    end else if(T206) begin
      state <= 5'hf;
    end else if(T203) begin
      state <= 5'he;
    end else if(T199) begin
      state <= 5'hb;
    end else if(T182) begin
      state <= 5'h9;
    end else if(T179) begin
      state <= 5'hd;
    end else if(T176) begin
      state <= 5'hc;
    end else if(T172) begin
      state <= 5'h9;
    end else if(T169) begin
      state <= 5'hb;
    end else if(T166) begin
      state <= 5'ha;
    end else if(T162) begin
      state <= 5'h7;
    end else if(T159) begin
      state <= 5'h3;
    end else if(T154) begin
      state <= 5'h11;
    end else if(T151) begin
      state <= 5'h8;
    end else if(T148) begin
      state <= 5'h7;
    end else if(T144) begin
      state <= 5'h4;
    end else if(T140) begin
      state <= 5'h5;
    end else if(T137) begin
      state <= 5'h1;
    end else if(T132) begin
      state <= 5'h3;
    end else if(T129) begin
      state <= 5'h6;
    end else if(T54) begin
      state <= 5'h5;
    end else if(T50) begin
      state <= 5'h2;
    end else if(T48) begin
      state <= 5'h1;
    end else if(T29) begin
      state <= 5'h9;
    end
    if(reset) begin
      ram_write_old <= 1'h0;
    end else if(T226) begin
      ram_write_old <= io_ram_write;
    end
    ram_addr_old <= T286;
    if(reset) begin
      counter <= 6'h0;
    end else if(T222) begin
      counter <= 6'h0;
    end else if(T125) begin
      counter <= T124;
    end else if(T213) begin
      counter <= 6'h0;
    end else if(T122) begin
      counter <= T121;
    end else if(T209) begin
      counter <= 6'h0;
    end else if(T206) begin
      counter <= 6'h0;
    end else if(T119) begin
      counter <= T118;
    end else if(T203) begin
      counter <= 6'h0;
    end else if(T116) begin
      counter <= T115;
    end else if(T199) begin
      counter <= 6'h0;
    end else if(T179) begin
      counter <= 6'h0;
    end else if(T113) begin
      counter <= T112;
    end else if(T176) begin
      counter <= 6'h0;
    end else if(T110) begin
      counter <= T109;
    end else if(T172) begin
      counter <= 6'h0;
    end else if(T169) begin
      counter <= 6'h0;
    end else if(T107) begin
      counter <= T106;
    end else if(T166) begin
      counter <= 6'h0;
    end else if(T104) begin
      counter <= T103;
    end else if(T162) begin
      counter <= 6'h0;
    end else if(T154) begin
      counter <= 6'h0;
    end else if(T151) begin
      counter <= 6'h0;
    end else if(T101) begin
      counter <= T100;
    end else if(T148) begin
      counter <= 6'h0;
    end else if(T98) begin
      counter <= T97;
    end else if(T144) begin
      counter <= 6'h0;
    end else if(T140) begin
      counter <= 6'h0;
    end else if(T132) begin
      counter <= 6'h0;
    end else if(T129) begin
      counter <= 6'h0;
    end else if(T95) begin
      counter <= T94;
    end else if(T54) begin
      counter <= 6'h0;
    end else if(T127) begin
      counter <= T93;
    end else if(T50) begin
      counter <= 6'h0;
    end else if(T32) begin
      counter <= 6'h0;
    end else if(io_init_calib_complete) begin
      counter <= T92;
    end
    if(reset) begin
      buffer_old <= 256'h0;
    end else if(T206) begin
      buffer_old <= T193;
    end else if(T169) begin
      buffer_old <= T187;
    end
    buffer <= T299;
  end
endmodule

