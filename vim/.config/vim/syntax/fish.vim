if exists ("b:current_syntax")
    finish
endif

let b:current_syntax = "fish"

syntax region fishComment start=+#+ end=+$+ keepend
syntax region fishString start=+'+ end=+'+ keepend
syntax region fishString start=+"+ end=+"+ keepend

syntax keyword fishConditional if else end_if then case section caseof case_of 
syntax keyword fishConditional end_case end_section endcase endif

syntax keyword fishRepeat loop end_loop while section command endcommand end_command endloop
syntax keyword fishFunction def end define defin defi function

syntax keyword fishWords1 a ap app appl apply array at att atta attac attach ca 
syntax keyword fishWords1 cal call con conf confi config constitutive_model 
syntax keyword fishWords1 constitutivemodel exit f_prop fish fishcall 
syntax keyword fishWords1 fix friend print while_stepping whilestepping 
syntax keyword fishWords1 grid help his ieb initial interface mark movie 
syntax keyword fishWords1 new plot quit restore return save sclin set solve set_color
syntax keyword fishWords1 stop structure sys title track water window cont 
syntax keyword fishWords1 conti contin continu continue co cop copy cycle cy 
syntax keyword fishWords1 cyc cycl free fr fre ge gen gene gener genera generat 
syntax keyword fishWords1 generate giic gr gro grou group he hel hist histo histor 
syntax keyword fishWords1 history iebo iebou ieboun iebound iebounda ieboundar 
syntax keyword fishWords1 ieboundary ini init initi initia inte inter interf interfa 
syntax keyword fishWords1 interfac interi interio interior ma mar model m mo mod opt 
syntax keyword fishWords1 pa pau paus pause pl plo pr pri prin q qu qui re res rest 
syntax keyword fishWords1 resto restor ret retu retur rez rezo rezon rezone sa sav sc 
syntax keyword fishWords1 scl scli se so sol solv ste step sto str stru struc struct 
syntax keyword fishWords1 structu structur syst syste system tab tabl tit titl tra trac 
syntax keyword fishWords1 unmark unma unmar wa wat wate w wi win wind windo

syntax keyword fishWords2 ex_
syntax keyword fishWords3 a_1 a_2 a_wipp a3 a4 act_energy alpha angle anisotropic 
syntax keyword fishWords3 app_pnt appgw_pnt appth_pnt area aspect asxx 
syntax keyword fishWords3 asxy asyy aszz atable att_pnt b_f b_wipp b0 b1 
syntax keyword fishWords3 b2 back baud bicoe bijoint bimatrix biot_c 
syntax keyword fishWords3 bsxx bsxy bsyy bszz bulk_current bulk_mod 
syntax keyword fishWords3 c2table camp camq cap_pressure cf_axi cf_creep 
syntax keyword fishWords3 cf_dyn cf_ext cf_gw cf_ps cf_therm cga char citable 
syntax keyword fishWords3 cj2table cjtable clock cm_max co2 cohesion columns 
syntax keyword fishWords3 con1 con2 conductivity cptable crdt creep crtdel crtime 
syntax keyword fishWords3 csxx csxy csyy cszz ctable cy_p cy_q d_f d_wipp d2table 
syntax keyword fishWords3 damp damping datum degrad density di2 dilation dilation_mob 
syntax keyword fishWords3 dj2table djtable do_update dsxx dsxy dsyy dszz dt dump 
syntax keyword fishWords3 dy dy_state dydt dydt_gpi dydt_gpj dynamic dytdel dytime 
syntax keyword fishWords3 e_dot_star e_p e_plastic e_primary echo econduct ega printf
syntax keyword fishWords3 ej_plastic elastic error es_plastic especc_heat et_plastic 
syntax keyword fishWords3 et_plastic ev_p ev_plastic ev_plastic ev_plsatic ev_tot f_qx 
syntax keyword fishWords3 f_qy f_t0 f2mod f2table ff_c1 ff_c2 ff_c3 ff_c4 ff_count ff_evd 
syntax keyword fishWords3 ff_latency ff_switch filcolor fish_msg fj2table fjtable flags 
syntax keyword fishWords3 flow flprop fmod fobl fobu force fos fos_f fr2 frac_d friction 
syntax keyword fishWords3 friction_mod fsi fsr ftable ftens g_thexp g2flow gas_c gflow 
syntax keyword fishWords3 gmsmul gp_copy gpp grand gwtdel gwtime hb_eplas hb_ind 
syntax keyword fishWords3 hba hbmb hbs hbs3cv hbsigci ieb_pnt ierr igp inimodel 
syntax keyword fishWords3 int_pnt izones jangle jc2 jcohesion jd2 jdilation jerr 
syntax keyword fishWords3 jf2 jfriction jpg jtension jzones jgp k_exx k_exy k_eyy 
syntax keyword fishWords3 k_ezz k_shear_mod k_viscosity k11 k11 k12 k12 k22 k22 
syntax keyword fishWords3 kappa kshear lambda large lconduct lspec_heat maxdt mechanical 
syntax keyword fishWords3 mesh_ratio mm mode mp1 mpc mtable multiplier mutable mv_1 mv0 
syntax keyword fishWords3 n_1 n_2 n_cond n_wipp nerr nerr_fish nuyx nuzx nwgpp per_table 
syntax keyword fishWords3 pi poiss por_table poro2 porosity power pp preparse qdil qvol 
syntax keyword fishWords3 rho rs1 rs2 rsat s_3dd s_dyn s_echo s_f s_flow s_g1 s_imp s_k1 
syntax keyword fishWords3 s_log s_mech s_mess s_movie sat shear_current shear_mod sm_max 
syntax keyword fishWords3 spec_heat ssi ssi3d ssr ssr3d stable state str_pnt sv sxx sxy 
syntax keyword fishWords3 syy szz thexp tab_pnt temp temp tenflg tension tflow thexp thtdel 
syntax keyword fishWords3 thtime tjable trac_pnt ttable udcoe udm_pnt unbal unbflow urand v_nmech 
syntax keyword fishWords3 v_ntherm vector vga vgp0 vgpcnw vgpcw viscosity visrat vol_strain 
syntax keyword fishWords3 vsi vsr vsxx vsxy vsyy vszz v_ngw wbiot wbulk wdens wk11 wk12 wk22 x 
syntax keyword fishWords3 xacc xbody xconduct xdisp xflow xforce xgrav xmod xnwflow xvel 
syntax keyword fishWords3 xyconduct y yacc ybody yconduct ydisp yflow yforce ygrav ymod 
syntax keyword fishWords3 ynwflow yvel z_group z_hyst z_model z_prop zart zde11 zde12 zde22 
syntax keyword fishWords3 zde33 zdpp zdrot zmsmul zporos zs11 zs12 zs22 zs33 zsub ztea zteb 
syntax keyword fishWords3 ztec zted ztsa ztsb ztsc ztsd zvisc zxbar csc gwdt hbm 
syntax keyword fishWords3 hisfile ieb_pnt iface implicit information itasca legend 
syntax keyword fishWords3 lff_pnt limits list lmul mem memory message mindt mohr-coulomb 
syntax keyword fishWords3 monchrome ncontours ncwrite ngrwater nmechanical nstep nthermal 
syntax keyword fishWords3 null output p_stress pac palette pfast pltangle pltcohesion pltfriction 
syntax keyword fishWords3 plttension pslow r r_integrate range rayleigh reset rff_pnt s_tens 
syntax keyword fishWords3 s_therm sig1 sig2 small ss temperature thdt thermal theta tolerance 
syntax keyword fishWords3 ubiquitous ucs udm_pnt umul v_ngw viscous vs wipp xform xreaction 
syntax keyword fishWords3 xywrite yreaction z_copy

syntax keyword fishWords4 abs acos and asin atan atan2 close cos cparse exp fc_arg 
syntax keyword fishWords4 float fmem fstring get_mem imem in int ln log lose_mem mat_inverse 
syntax keyword fishWords4 mat_transpose max min not open or out parse pre_parse read rez_exe sclose 
syntax keyword fishWords4 sgn sin sopen sqrt sread string swrite table_size tan type 
syntax keyword fishWords4 write xtable ytable 
syntax keyword fishWords4 beam ddonut donut hole qdonut reg_add pr_struc ps3d 
syntax keyword fishWords4 region disp_mag extrap_to_gp 
syntax keyword fishWords4 mc_fos ps servo zonk relax m_camclay m_drucker m_dy m_elas 
syntax keyword fishWords4 finn supsolve hyper m_duncan 
syntax keyword fishWords4 m_mohr m_ss bond_s int_var m_ubi spup ininv i_stress ps 
syntax keyword fishWords4 derivative erf erfc exp_int 
syntax keyword fishWords4 filter fftransform froot integrate ludcmp lubksb _modred number spectrum

syntax match fishRegexPrivate "__\w*"       "Matches any word that begins with __.
syntax match fishRegexArgument "--\w*"      "Matches any word that begins with --.
syntax match fishRegexOption "-\w*[^-]"     "Matches any word that begins with --.
 
hi FishWords cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#00bcd4 guibg=NONE
hi FishConditionals cterm=BOLD ctermfg=NONE ctermbg=NONE gui=BOLD guifg=#00bcd4 guibg=NONE
hi FishPrintf cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#d400bc guibg=NONE
hi FishArgument cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#588383 guibg=NONE
hi FishPrivate cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#00bcd4 guibg=NONE
hi FishOption cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=#d400bc guibg=NONE

hi link fishComment Comment
hi link fishString String
hi link fishConditional FishConditionals
hi link fishRepeat Repeat
hi link fishFunction Function

hi link fishWords1 FishWords
hi link fishWords2 FishWords
hi link fishWords3 FishWords
hi link fishWords4 FishWords

hi link fishRegexPrintf FishPrintf
hi link fishRegexArgument FishArgument
hi link fishRegexPrivate FishPrivate
hi link fishRegexOption FishOption
