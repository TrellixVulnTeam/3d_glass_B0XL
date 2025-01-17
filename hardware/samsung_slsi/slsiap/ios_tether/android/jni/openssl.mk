#openssl

LIB_VERSION:=openssl-android/openssl

LOCAL_PATH:= $(call my-dir)
LIB_ROOT_REL:= ../../$(LIB_VERSION)
LIB_ROOT_ABS:= $(LOCAL_PATH)/../../$(LIB_VERSION)

#libcyrpto

include $(CLEAR_VARS)

LOCAL_CFLAGS := -DNO_WINDOWS_BRAINDEATH -DOPENSSL_BN_ASM_MONT -DAES_ASM -DSHA1_ASM \
    -DSHA256_ASM -DSHA512_ASM -DOPENSSL_NO_CAMELLIA -DOPENSSL_NO_CAPIENG \
    -DOPENSSL_NO_CAST -DOPENSSL_NO_CMS -DOPENSSL_NO_GMP -DOPENSSL_NO_IDEA \
    -DOPENSSL_NO_JPAKE -DOPENSSL_NO_MD2 -DOPENSSL_NO_MDC2 -DOPENSSL_NO_RC5 \
    -DOPENSSL_NO_SHA0 -DOPENSSL_NO_RFC3779 -DOPENSSL_NO_SEED -DOPENSSL_NO_STORE \
    -DOPENSSL_NO_WHIRLPOOL -DOPENSSL_THREADS -D_REENTRANT -DPURIFY -DOPENSSL_NO_HW \
    -DOPENSSL_NO_ENGINE -DOPENSSL_NO_DEPRECATED -DPTHREADS -DZLIB  -D__ANDROID__

LOCAL_SRC_FILES := \
 $(LIB_ROOT_REL)/crypto/cryptlib.c \
 $(LIB_ROOT_REL)/crypto/mem.c \
 $(LIB_ROOT_REL)/crypto/mem_clr.c \
 $(LIB_ROOT_REL)/crypto/mem_dbg.c \
 $(LIB_ROOT_REL)/crypto/cversion.c \
 $(LIB_ROOT_REL)/crypto/ex_data.c \
 $(LIB_ROOT_REL)/crypto/cpt_err.c \
 $(LIB_ROOT_REL)/crypto/ebcdic.c \
 $(LIB_ROOT_REL)/crypto/uid.c \
 $(LIB_ROOT_REL)/crypto/o_time.c \
 $(LIB_ROOT_REL)/crypto/o_str.c \
 $(LIB_ROOT_REL)/crypto/o_dir.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_cbc.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_cfb.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_ctr.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_ecb.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_misc.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_ofb.c \
 $(LIB_ROOT_REL)/crypto/aes/aes_wrap.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_bitstr.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_bool.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_bytes.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_d2i_fp.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_digest.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_dup.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_enum.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_gentm.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_i2d_fp.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_int.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_mbstr.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_object.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_octet.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_print.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_set.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_sign.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_strex.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_strnid.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_time.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_type.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_utctm.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_utf8.c \
 $(LIB_ROOT_REL)/crypto/asn1/a_verify.c \
 $(LIB_ROOT_REL)/crypto/asn1/ameth_lib.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn1_err.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn1_gen.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn1_lib.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn1_par.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn_mime.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn_moid.c \
 $(LIB_ROOT_REL)/crypto/asn1/asn_pack.c \
 $(LIB_ROOT_REL)/crypto/asn1/bio_asn1.c \
 $(LIB_ROOT_REL)/crypto/asn1/bio_ndef.c \
 $(LIB_ROOT_REL)/crypto/asn1/d2i_pr.c \
 $(LIB_ROOT_REL)/crypto/asn1/d2i_pu.c \
 $(LIB_ROOT_REL)/crypto/asn1/evp_asn1.c \
 $(LIB_ROOT_REL)/crypto/asn1/f_enum.c \
 $(LIB_ROOT_REL)/crypto/asn1/f_int.c \
 $(LIB_ROOT_REL)/crypto/asn1/f_string.c \
 $(LIB_ROOT_REL)/crypto/asn1/i2d_pr.c \
 $(LIB_ROOT_REL)/crypto/asn1/i2d_pu.c \
 $(LIB_ROOT_REL)/crypto/asn1/n_pkey.c \
 $(LIB_ROOT_REL)/crypto/asn1/nsseq.c \
 $(LIB_ROOT_REL)/crypto/asn1/p5_pbe.c \
 $(LIB_ROOT_REL)/crypto/asn1/p5_pbev2.c \
 $(LIB_ROOT_REL)/crypto/asn1/p8_pkey.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_bitst.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_crl.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_pkey.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_req.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_spki.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_x509.c \
 $(LIB_ROOT_REL)/crypto/asn1/t_x509a.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_dec.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_enc.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_fre.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_new.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_prn.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_typ.c \
 $(LIB_ROOT_REL)/crypto/asn1/tasn_utl.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_algor.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_attrib.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_bignum.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_crl.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_exten.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_info.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_long.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_name.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_nx509.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_pkey.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_pubkey.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_req.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_sig.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_spki.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_val.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_x509.c \
 $(LIB_ROOT_REL)/crypto/asn1/x_x509a.c \
 $(LIB_ROOT_REL)/crypto/bf/bf_cfb64.c \
 $(LIB_ROOT_REL)/crypto/bf/bf_ecb.c \
 $(LIB_ROOT_REL)/crypto/bf/bf_enc.c \
 $(LIB_ROOT_REL)/crypto/bf/bf_ofb64.c \
 $(LIB_ROOT_REL)/crypto/bf/bf_skey.c \
 $(LIB_ROOT_REL)/crypto/bio/b_dump.c \
 $(LIB_ROOT_REL)/crypto/bio/b_print.c \
 $(LIB_ROOT_REL)/crypto/bio/b_sock.c \
 $(LIB_ROOT_REL)/crypto/bio/bf_buff.c \
 $(LIB_ROOT_REL)/crypto/bio/bf_nbio.c \
 $(LIB_ROOT_REL)/crypto/bio/bf_null.c \
 $(LIB_ROOT_REL)/crypto/bio/bio_cb.c \
 $(LIB_ROOT_REL)/crypto/bio/bio_err.c \
 $(LIB_ROOT_REL)/crypto/bio/bio_lib.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_acpt.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_bio.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_conn.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_dgram.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_fd.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_file.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_log.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_mem.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_null.c \
 $(LIB_ROOT_REL)/crypto/bio/bss_sock.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_add.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_asm.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_blind.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_ctx.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_div.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_err.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_exp.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_exp2.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_gcd.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_gf2m.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_kron.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_lib.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_mod.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_mont.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_mpi.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_mul.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_nist.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_prime.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_print.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_rand.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_recp.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_shift.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_sqr.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_sqrt.c \
 $(LIB_ROOT_REL)/crypto/bn/bn_word.c \
 $(LIB_ROOT_REL)/crypto/buffer/buf_err.c \
 $(LIB_ROOT_REL)/crypto/buffer/buffer.c \
 $(LIB_ROOT_REL)/crypto/comp/c_rle.c \
 $(LIB_ROOT_REL)/crypto/comp/c_zlib.c \
 $(LIB_ROOT_REL)/crypto/comp/comp_err.c \
 $(LIB_ROOT_REL)/crypto/comp/comp_lib.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_api.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_def.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_err.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_lib.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_mall.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_mod.c \
 $(LIB_ROOT_REL)/crypto/conf/conf_sap.c \
 $(LIB_ROOT_REL)/crypto/des/cbc_cksm.c \
 $(LIB_ROOT_REL)/crypto/des/cbc_enc.c \
 $(LIB_ROOT_REL)/crypto/des/cfb64ede.c \
 $(LIB_ROOT_REL)/crypto/des/cfb64enc.c \
 $(LIB_ROOT_REL)/crypto/des/cfb_enc.c \
 $(LIB_ROOT_REL)/crypto/des/des_enc.c \
 $(LIB_ROOT_REL)/crypto/des/des_old.c \
 $(LIB_ROOT_REL)/crypto/des/des_old2.c \
 $(LIB_ROOT_REL)/crypto/des/ecb3_enc.c \
 $(LIB_ROOT_REL)/crypto/des/ecb_enc.c \
 $(LIB_ROOT_REL)/crypto/des/ede_cbcm_enc.c \
 $(LIB_ROOT_REL)/crypto/des/enc_read.c \
 $(LIB_ROOT_REL)/crypto/des/enc_writ.c \
 $(LIB_ROOT_REL)/crypto/des/fcrypt.c \
 $(LIB_ROOT_REL)/crypto/des/fcrypt_b.c \
 $(LIB_ROOT_REL)/crypto/des/ofb64ede.c \
 $(LIB_ROOT_REL)/crypto/des/ofb64enc.c \
 $(LIB_ROOT_REL)/crypto/des/ofb_enc.c \
 $(LIB_ROOT_REL)/crypto/des/pcbc_enc.c \
 $(LIB_ROOT_REL)/crypto/des/qud_cksm.c \
 $(LIB_ROOT_REL)/crypto/des/rand_key.c \
 $(LIB_ROOT_REL)/crypto/des/read2pwd.c \
 $(LIB_ROOT_REL)/crypto/des/rpc_enc.c \
 $(LIB_ROOT_REL)/crypto/des/set_key.c \
 $(LIB_ROOT_REL)/crypto/des/str2key.c \
 $(LIB_ROOT_REL)/crypto/des/xcbc_enc.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_ameth.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_asn1.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_check.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_depr.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_err.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_gen.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_key.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_lib.c \
 $(LIB_ROOT_REL)/crypto/dh/dh_pmeth.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_ameth.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_asn1.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_depr.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_err.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_gen.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_key.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_lib.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_ossl.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_pmeth.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_prn.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_sign.c \
 $(LIB_ROOT_REL)/crypto/dsa/dsa_vrf.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_dl.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_dlfcn.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_err.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_lib.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_null.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_openssl.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_vms.c \
 $(LIB_ROOT_REL)/crypto/dso/dso_win32.c \
 $(LIB_ROOT_REL)/crypto/ec/ec2_mult.c \
 $(LIB_ROOT_REL)/crypto/ec/ec2_smpl.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_ameth.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_asn1.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_check.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_curve.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_cvt.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_err.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_key.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_lib.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_mult.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_pmeth.c \
 $(LIB_ROOT_REL)/crypto/ec/ec_print.c \
 $(LIB_ROOT_REL)/crypto/ec/eck_prn.c \
 $(LIB_ROOT_REL)/crypto/ec/ecp_mont.c \
 $(LIB_ROOT_REL)/crypto/ec/ecp_nist.c \
 $(LIB_ROOT_REL)/crypto/ec/ecp_smpl.c \
 $(LIB_ROOT_REL)/crypto/ecdh/ech_err.c \
 $(LIB_ROOT_REL)/crypto/ecdh/ech_key.c \
 $(LIB_ROOT_REL)/crypto/ecdh/ech_lib.c \
 $(LIB_ROOT_REL)/crypto/ecdh/ech_ossl.c \
 $(LIB_ROOT_REL)/crypto/ecdsa/ecs_asn1.c \
 $(LIB_ROOT_REL)/crypto/ecdsa/ecs_err.c \
 $(LIB_ROOT_REL)/crypto/ecdsa/ecs_lib.c \
 $(LIB_ROOT_REL)/crypto/ecdsa/ecs_ossl.c \
 $(LIB_ROOT_REL)/crypto/ecdsa/ecs_sign.c \
 $(LIB_ROOT_REL)/crypto/ecdsa/ecs_vrf.c \
 $(LIB_ROOT_REL)/crypto/err/err.c \
 $(LIB_ROOT_REL)/crypto/err/err_all.c \
 $(LIB_ROOT_REL)/crypto/err/err_prn.c \
 $(LIB_ROOT_REL)/crypto/evp/bio_b64.c \
 $(LIB_ROOT_REL)/crypto/evp/bio_enc.c \
 $(LIB_ROOT_REL)/crypto/evp/bio_md.c \
 $(LIB_ROOT_REL)/crypto/evp/bio_ok.c \
 $(LIB_ROOT_REL)/crypto/evp/c_all.c \
 $(LIB_ROOT_REL)/crypto/evp/c_allc.c \
 $(LIB_ROOT_REL)/crypto/evp/c_alld.c \
 $(LIB_ROOT_REL)/crypto/evp/digest.c \
 $(LIB_ROOT_REL)/crypto/evp/e_aes.c \
 $(LIB_ROOT_REL)/crypto/evp/e_bf.c \
 $(LIB_ROOT_REL)/crypto/evp/e_des.c \
 $(LIB_ROOT_REL)/crypto/evp/e_des3.c \
 $(LIB_ROOT_REL)/crypto/evp/e_null.c \
 $(LIB_ROOT_REL)/crypto/evp/e_old.c \
 $(LIB_ROOT_REL)/crypto/evp/e_rc2.c \
 $(LIB_ROOT_REL)/crypto/evp/e_rc4.c \
 $(LIB_ROOT_REL)/crypto/evp/e_rc5.c \
 $(LIB_ROOT_REL)/crypto/evp/e_xcbc_d.c \
 $(LIB_ROOT_REL)/crypto/evp/encode.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_acnf.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_enc.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_err.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_key.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_lib.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_pbe.c \
 $(LIB_ROOT_REL)/crypto/evp/evp_pkey.c \
 $(LIB_ROOT_REL)/crypto/evp/m_dss.c \
 $(LIB_ROOT_REL)/crypto/evp/m_dss1.c \
 $(LIB_ROOT_REL)/crypto/evp/m_ecdsa.c \
 $(LIB_ROOT_REL)/crypto/evp/m_md4.c \
 $(LIB_ROOT_REL)/crypto/evp/m_md5.c \
 $(LIB_ROOT_REL)/crypto/evp/m_mdc2.c \
 $(LIB_ROOT_REL)/crypto/evp/m_null.c \
 $(LIB_ROOT_REL)/crypto/evp/m_ripemd.c \
 $(LIB_ROOT_REL)/crypto/evp/m_sha1.c \
 $(LIB_ROOT_REL)/crypto/evp/m_sigver.c \
 $(LIB_ROOT_REL)/crypto/evp/m_wp.c \
 $(LIB_ROOT_REL)/crypto/evp/names.c \
 $(LIB_ROOT_REL)/crypto/evp/p5_crpt.c \
 $(LIB_ROOT_REL)/crypto/evp/p5_crpt2.c \
 $(LIB_ROOT_REL)/crypto/evp/p_dec.c \
 $(LIB_ROOT_REL)/crypto/evp/p_enc.c \
 $(LIB_ROOT_REL)/crypto/evp/p_lib.c \
 $(LIB_ROOT_REL)/crypto/evp/p_open.c \
 $(LIB_ROOT_REL)/crypto/evp/p_seal.c \
 $(LIB_ROOT_REL)/crypto/evp/p_sign.c \
 $(LIB_ROOT_REL)/crypto/evp/p_verify.c \
 $(LIB_ROOT_REL)/crypto/evp/pmeth_fn.c \
 $(LIB_ROOT_REL)/crypto/evp/pmeth_gn.c \
 $(LIB_ROOT_REL)/crypto/evp/pmeth_lib.c \
 $(LIB_ROOT_REL)/crypto/hmac/hm_ameth.c \
 $(LIB_ROOT_REL)/crypto/hmac/hm_pmeth.c \
 $(LIB_ROOT_REL)/crypto/hmac/hmac.c \
 $(LIB_ROOT_REL)/crypto/krb5/krb5_asn.c \
 $(LIB_ROOT_REL)/crypto/lhash/lh_stats.c \
 $(LIB_ROOT_REL)/crypto/lhash/lhash.c \
 $(LIB_ROOT_REL)/crypto/md4/md4_dgst.c \
 $(LIB_ROOT_REL)/crypto/md4/md4_one.c \
 $(LIB_ROOT_REL)/crypto/md5/md5_dgst.c \
 $(LIB_ROOT_REL)/crypto/md5/md5_one.c \
 $(LIB_ROOT_REL)/crypto/modes/cbc128.c \
 $(LIB_ROOT_REL)/crypto/modes/cfb128.c \
 $(LIB_ROOT_REL)/crypto/modes/ctr128.c \
 $(LIB_ROOT_REL)/crypto/modes/ofb128.c \
 $(LIB_ROOT_REL)/crypto/objects/o_names.c \
 $(LIB_ROOT_REL)/crypto/objects/obj_dat.c \
 $(LIB_ROOT_REL)/crypto/objects/obj_err.c \
 $(LIB_ROOT_REL)/crypto/objects/obj_lib.c \
 $(LIB_ROOT_REL)/crypto/objects/obj_xref.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_asn.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_cl.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_err.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_ext.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_ht.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_lib.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_prn.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_srv.c \
 $(LIB_ROOT_REL)/crypto/ocsp/ocsp_vfy.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_all.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_err.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_info.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_lib.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_oth.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_pk8.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_pkey.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_seal.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_sign.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_x509.c \
 $(LIB_ROOT_REL)/crypto/pem/pem_xaux.c \
 $(LIB_ROOT_REL)/crypto/pem/pvkfmt.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_add.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_asn.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_attr.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_crpt.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_crt.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_decr.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_init.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_key.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_kiss.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_mutl.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_npas.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_p8d.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_p8e.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/p12_utl.c \
 $(LIB_ROOT_REL)/crypto/pkcs12/pk12err.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pk7_asn1.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pk7_attr.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pk7_doit.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pk7_lib.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pk7_mime.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pk7_smime.c \
 $(LIB_ROOT_REL)/crypto/pkcs7/pkcs7err.c \
 $(LIB_ROOT_REL)/crypto/rand/md_rand.c \
 $(LIB_ROOT_REL)/crypto/rand/rand_egd.c \
 $(LIB_ROOT_REL)/crypto/rand/rand_err.c \
 $(LIB_ROOT_REL)/crypto/rand/rand_lib.c \
 $(LIB_ROOT_REL)/crypto/rand/rand_unix.c \
 $(LIB_ROOT_REL)/crypto/rand/randfile.c \
 $(LIB_ROOT_REL)/crypto/rc2/rc2_cbc.c \
 $(LIB_ROOT_REL)/crypto/rc2/rc2_ecb.c \
 $(LIB_ROOT_REL)/crypto/rc2/rc2_skey.c \
 $(LIB_ROOT_REL)/crypto/rc2/rc2cfb64.c \
 $(LIB_ROOT_REL)/crypto/rc2/rc2ofb64.c \
 $(LIB_ROOT_REL)/crypto/rc4/rc4_enc.c \
 $(LIB_ROOT_REL)/crypto/rc4/rc4_skey.c \
 $(LIB_ROOT_REL)/crypto/ripemd/rmd_dgst.c \
 $(LIB_ROOT_REL)/crypto/ripemd/rmd_one.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_ameth.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_asn1.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_chk.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_eay.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_err.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_gen.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_lib.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_none.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_null.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_oaep.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_pk1.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_pmeth.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_prn.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_pss.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_saos.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_sign.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_ssl.c \
 $(LIB_ROOT_REL)/crypto/rsa/rsa_x931.c \
 $(LIB_ROOT_REL)/crypto/sha/sha1_one.c \
 $(LIB_ROOT_REL)/crypto/sha/sha1dgst.c \
 $(LIB_ROOT_REL)/crypto/sha/sha256.c \
 $(LIB_ROOT_REL)/crypto/sha/sha512.c \
 $(LIB_ROOT_REL)/crypto/sha/sha_dgst.c \
 $(LIB_ROOT_REL)/crypto/stack/stack.c \
 $(LIB_ROOT_REL)/crypto/ts/ts_err.c \
 $(LIB_ROOT_REL)/crypto/txt_db/txt_db.c \
 $(LIB_ROOT_REL)/crypto/ui/ui_compat.c \
 $(LIB_ROOT_REL)/crypto/ui/ui_err.c \
 $(LIB_ROOT_REL)/crypto/ui/ui_lib.c \
 $(LIB_ROOT_REL)/crypto/ui/ui_openssl.c \
 $(LIB_ROOT_REL)/crypto/ui/ui_util.c \
 $(LIB_ROOT_REL)/crypto/x509/by_dir.c \
 $(LIB_ROOT_REL)/crypto/x509/by_file.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_att.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_cmp.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_d2.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_def.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_err.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_ext.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_lu.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_obj.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_r2x.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_req.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_set.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_trs.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_txt.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_v3.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_vfy.c \
 $(LIB_ROOT_REL)/crypto/x509/x509_vpm.c \
 $(LIB_ROOT_REL)/crypto/x509/x509cset.c \
 $(LIB_ROOT_REL)/crypto/x509/x509name.c \
 $(LIB_ROOT_REL)/crypto/x509/x509rset.c \
 $(LIB_ROOT_REL)/crypto/x509/x509spki.c \
 $(LIB_ROOT_REL)/crypto/x509/x509type.c \
 $(LIB_ROOT_REL)/crypto/x509/x_all.c \
 $(LIB_ROOT_REL)/crypto/x509v3/pcy_cache.c \
 $(LIB_ROOT_REL)/crypto/x509v3/pcy_data.c \
 $(LIB_ROOT_REL)/crypto/x509v3/pcy_lib.c \
 $(LIB_ROOT_REL)/crypto/x509v3/pcy_map.c \
 $(LIB_ROOT_REL)/crypto/x509v3/pcy_node.c \
 $(LIB_ROOT_REL)/crypto/x509v3/pcy_tree.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_akey.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_akeya.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_alt.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_bcons.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_bitst.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_conf.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_cpols.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_crld.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_enum.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_extku.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_genn.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_ia5.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_info.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_int.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_lib.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_ncons.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_ocsp.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_pci.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_pcia.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_pcons.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_pku.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_pmaps.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_prn.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_purp.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_skey.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_sxnet.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3_utl.c \
 $(LIB_ROOT_REL)/crypto/x509v3/v3err.c \
 $(LIB_ROOT_REL)/crypto/aes/asm/aes-armv4.S \
 $(LIB_ROOT_REL)/crypto/bn/asm/armv4-mont.S \
 $(LIB_ROOT_REL)/crypto/sha/asm/sha1-armv4-large.S \
 $(LIB_ROOT_REL)/crypto/sha/asm/sha256-armv4.S \
 $(LIB_ROOT_REL)/crypto/sha/asm/sha512-armv4.S

LOCAL_C_INCLUDES := \
 $(LIB_ROOT_ABS) \
 $(LIB_ROOT_ABS)/crypto \
 $(LIB_ROOT_ABS)/crypto/asn1 \
 $(LIB_ROOT_ABS)/crypto/evp \
 $(LIB_ROOT_ABS)/include \
 $(LIB_ROOT_ABS)/include/openssl \
 $(LIB_ROOT_ABS)/../../usbmuxd/out/toolchain/sysroot/usr/include \
 $(LIB_ROOT_ABS)/../../usbmuxd/out/toolchain/include/c++/4.8

LOCAL_LDLIBS += \
 -lz \
 -ldl

LOCAL_MODULE:= libcrypto
include $(BUILD_SHARED_LIBRARY)


#libssl

include $(CLEAR_VARS)

LOCAL_CFLAGS := -DNO_WINDOWS_BRAINDEATH -DOPENSSL_BN_ASM_MONT -DAES_ASM -DSHA1_ASM \
    -DSHA256_ASM -DSHA512_ASM -DOPENSSL_NO_CAMELLIA -DOPENSSL_NO_CAPIENG -DOPENSSL_NO_CAST \
    -DOPENSSL_NO_CMS -DOPENSSL_NO_GMP -DOPENSSL_NO_IDEA -DOPENSSL_NO_JPAKE -DOPENSSL_NO_MD2 \
    -DOPENSSL_NO_MDC2 -DOPENSSL_NO_RC5 -DOPENSSL_NO_SHA0 -DOPENSSL_NO_RFC3779 -DOPENSSL_NO_SEED \
    -DOPENSSL_NO_STORE -DOPENSSL_NO_WHIRLPOOL -DOPENSSL_THREADS -D_REENTRANT -DPURIFY -DOPENSSL_NO_HW \
    -DOPENSSL_NO_ENGINE -DOPENSSL_NO_DEPRECATED -DZLIB -D__ANDROID__

LOCAL_SRC_FILES := \
 $(LIB_ROOT_REL)/ssl/s2_meth.c \
 $(LIB_ROOT_REL)/ssl/s2_srvr.c \
 $(LIB_ROOT_REL)/ssl/s2_clnt.c \
 $(LIB_ROOT_REL)/ssl/s2_lib.c \
 $(LIB_ROOT_REL)/ssl/s2_enc.c \
 $(LIB_ROOT_REL)/ssl/s2_pkt.c \
 $(LIB_ROOT_REL)/ssl/s3_meth.c \
 $(LIB_ROOT_REL)/ssl/s3_srvr.c \
 $(LIB_ROOT_REL)/ssl/s3_clnt.c \
 $(LIB_ROOT_REL)/ssl/s3_lib.c \
 $(LIB_ROOT_REL)/ssl/s3_enc.c \
 $(LIB_ROOT_REL)/ssl/s3_pkt.c \
 $(LIB_ROOT_REL)/ssl/s3_both.c \
 $(LIB_ROOT_REL)/ssl/s23_meth.c \
 $(LIB_ROOT_REL)/ssl/s23_srvr.c \
 $(LIB_ROOT_REL)/ssl/s23_clnt.c \
 $(LIB_ROOT_REL)/ssl/s23_lib.c \
 $(LIB_ROOT_REL)/ssl/s23_pkt.c \
 $(LIB_ROOT_REL)/ssl/t1_meth.c \
 $(LIB_ROOT_REL)/ssl/t1_srvr.c \
 $(LIB_ROOT_REL)/ssl/t1_clnt.c \
 $(LIB_ROOT_REL)/ssl/t1_lib.c \
 $(LIB_ROOT_REL)/ssl/t1_enc.c \
 $(LIB_ROOT_REL)/ssl/t1_reneg.c \
 $(LIB_ROOT_REL)/ssl/ssl_lib.c \
 $(LIB_ROOT_REL)/ssl/ssl_err2.c \
 $(LIB_ROOT_REL)/ssl/ssl_cert.c \
 $(LIB_ROOT_REL)/ssl/ssl_sess.c \
 $(LIB_ROOT_REL)/ssl/ssl_ciph.c \
 $(LIB_ROOT_REL)/ssl/ssl_stat.c \
 $(LIB_ROOT_REL)/ssl/ssl_rsa.c \
 $(LIB_ROOT_REL)/ssl/ssl_asn1.c \
 $(LIB_ROOT_REL)/ssl/ssl_txt.c \
 $(LIB_ROOT_REL)/ssl/ssl_algs.c \
 $(LIB_ROOT_REL)/ssl/bio_ssl.c \
 $(LIB_ROOT_REL)/ssl/ssl_err.c \
 $(LIB_ROOT_REL)/ssl/kssl.c

LOCAL_C_INCLUDES := \
 $(LIB_ROOT_ABS) \
 $(LIB_ROOT_ABS)/include \
 $(LIB_ROOT_ABS)/crypto \
 $(LIB_ROOT_ABS)/../../usbmuxd/out/toolchain/sysroot/usr/include \
 $(LIB_ROOT_ABS)/../../usbmuxd/out/toolchain/include/c++/4.8

LOCAL_LDLIBS += \
 -lz \
 -ldl

LOCAL_SHARED_LIBRARIES := libcrypto

LOCAL_MODULE:= libssl
include $(BUILD_SHARED_LIBRARY)

#openssl

include $(CLEAR_VARS)

LOCAL_CFLAGS := -DNO_WINDOWS_BRAINDEATH -DOPENSSL_BN_ASM_MONT -DAES_ASM -DSHA1_ASM -DSHA256_ASM \
    -DSHA512_ASM -DOPENSSL_NO_CAMELLIA -DOPENSSL_NO_CAPIENG -DOPENSSL_NO_CAST -DOPENSSL_NO_CMS \
    -DOPENSSL_NO_GMP -DOPENSSL_NO_IDEA -DOPENSSL_NO_JPAKE -DOPENSSL_NO_MD2 -DOPENSSL_NO_MDC2 \
    -DOPENSSL_NO_RC5 -DOPENSSL_NO_SHA0 -DOPENSSL_NO_RFC3779 -DOPENSSL_NO_SEED -DOPENSSL_NO_STORE \
    -DOPENSSL_NO_WHIRLPOOL -DOPENSSL_THREADS -D_REENTRANT -DPURIFY -DOPENSSL_NO_HW -DOPENSSL_NO_ENGINE \
    -DOPENSSL_NO_DEPRECATED -DZLIB -DMONOLITH -DOPENSSL_NO_DTLS1 -D__ANDROID__

LOCAL_SRC_FILES := \
 $(LIB_ROOT_REL)/apps/app_rand.c \
 $(LIB_ROOT_REL)/apps/apps.c \
 $(LIB_ROOT_REL)/apps/asn1pars.c \
 $(LIB_ROOT_REL)/apps/ca.c \
 $(LIB_ROOT_REL)/apps/ciphers.c \
 $(LIB_ROOT_REL)/apps/crl.c \
 $(LIB_ROOT_REL)/apps/crl2p7.c \
 $(LIB_ROOT_REL)/apps/dgst.c \
 $(LIB_ROOT_REL)/apps/dh.c \
 $(LIB_ROOT_REL)/apps/dhparam.c \
 $(LIB_ROOT_REL)/apps/dsa.c \
 $(LIB_ROOT_REL)/apps/dsaparam.c \
 $(LIB_ROOT_REL)/apps/ecparam.c \
 $(LIB_ROOT_REL)/apps/ec.c \
 $(LIB_ROOT_REL)/apps/enc.c \
 $(LIB_ROOT_REL)/apps/engine.c \
 $(LIB_ROOT_REL)/apps/errstr.c \
 $(LIB_ROOT_REL)/apps/gendh.c \
 $(LIB_ROOT_REL)/apps/gendsa.c \
 $(LIB_ROOT_REL)/apps/genpkey.c \
 $(LIB_ROOT_REL)/apps/genrsa.c \
 $(LIB_ROOT_REL)/apps/nseq.c \
 $(LIB_ROOT_REL)/apps/ocsp.c \
 $(LIB_ROOT_REL)/apps/openssl.c \
 $(LIB_ROOT_REL)/apps/passwd.c \
 $(LIB_ROOT_REL)/apps/pkcs12.c \
 $(LIB_ROOT_REL)/apps/pkcs7.c \
 $(LIB_ROOT_REL)/apps/pkcs8.c \
 $(LIB_ROOT_REL)/apps/pkey.c \
 $(LIB_ROOT_REL)/apps/pkeyparam.c \
 $(LIB_ROOT_REL)/apps/pkeyutl.c \
 $(LIB_ROOT_REL)/apps/prime.c \
 $(LIB_ROOT_REL)/apps/rand.c \
 $(LIB_ROOT_REL)/apps/req.c \
 $(LIB_ROOT_REL)/apps/rsa.c \
 $(LIB_ROOT_REL)/apps/rsautl.c \
 $(LIB_ROOT_REL)/apps/s_cb.c \
 $(LIB_ROOT_REL)/apps/s_client.c \
 $(LIB_ROOT_REL)/apps/s_server.c \
 $(LIB_ROOT_REL)/apps/s_socket.c \
 $(LIB_ROOT_REL)/apps/s_time.c \
 $(LIB_ROOT_REL)/apps/sess_id.c \
 $(LIB_ROOT_REL)/apps/smime.c \
 $(LIB_ROOT_REL)/apps/speed.c \
 $(LIB_ROOT_REL)/apps/spkac.c \
 $(LIB_ROOT_REL)/apps/verify.c \
 $(LIB_ROOT_REL)/apps/version.c \
 $(LIB_ROOT_REL)/apps/x509.c

LOCAL_C_INCLUDES := \
 $(LIB_ROOT_ABS) \
 $(LIB_ROOT_ABS)/include \
 $(LIB_ROOT_ABS)/crypto \
 $(LIB_ROOT_ABS)/../../usbmuxd/out/toolchain/sysroot/usr/include \
 $(LIB_ROOT_ABS)/../../usbmuxd/out/toolchain/include/c++/4.8

LOCAL_SHARED_LIBRARIES := libcrypto libssl

LOCAL_MODULE:= openssl
include $(BUILD_EXECUTABLE)