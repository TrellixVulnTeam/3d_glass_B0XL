/*
 * (C) Copyright 2009
 * jung hyun kim, Nexell Co, <jhkim@nexell.co.kr>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */
#include <config.h>
#include <common.h>
#include <mmc.h>
#include <pwm.h>
#include <asm/io.h>
#include <asm/gpio.h>

#include <platform.h>
#include <tags.h>
#include <mach-api.h>
#include <rtc_nxp.h>
#include <pm.h>

//#include "fastboot.h"
#if defined(CONFIG_PMIC_NXE2000)
#include <power/pmic.h>
#include <nxe2000-private.h>
#endif

DECLARE_GLOBAL_DATA_PTR;

#if defined(CONFIG_DRIVER_DM9000) || defined(CONFIG_DESIGNWARE_ETH)
#include "eth.c"
#endif

#if (0)
#define DBGOUT(msg...)		{ printf("BD: " msg); }
#else
#define DBGOUT(msg...)		do {} while (0)
#endif

/*------------------------------------------------------------------------------
 * BUS Configure
 */
#if (CFG_BUS_RECONFIG_ENB == 1)
#include <asm/arch/s5p4418_bus.h>

const u8 g_DrexBRB_RD[2] = {
	0x1,            // Port0
	0xF             // Port1
};

const u8 g_DrexBRB_WR[2] = {
	0x1,            // Port0
	0xF             // Port1
};

const u16 g_DrexQoS[2] = {
	0x100,          // S0
	0xFFF           // S1, Default value
};


#if (CFG_BUS_RECONFIG_TOPBUSSI == 1)
const u8 g_TopBusSI[8] = {
	TOPBUS_SI_SLOT_DMAC0,
	TOPBUS_SI_SLOT_USBOTG,
	TOPBUS_SI_SLOT_USBHOST0,
	TOPBUS_SI_SLOT_DMAC1,
	TOPBUS_SI_SLOT_SDMMC,
	TOPBUS_SI_SLOT_USBOTG,
	TOPBUS_SI_SLOT_USBHOST1,
	TOPBUS_SI_SLOT_USBOTG
};
#endif

#if (CFG_BUS_RECONFIG_TOPBUSQOS == 1)
const u8 g_TopQoSSI[2] = {
	1,      // Tidemark
	(1<<TOPBUS_SI_SLOT_DMAC0) |     // Control
	(1<<TOPBUS_SI_SLOT_MP2TS) |
	(1<<TOPBUS_SI_SLOT_DMAC1) |
	(1<<TOPBUS_SI_SLOT_SDMMC) |
	(1<<TOPBUS_SI_SLOT_USBOTG) |
	(1<<TOPBUS_SI_SLOT_USBHOST0) |
	(1<<TOPBUS_SI_SLOT_USBHOST1)
};
#endif

#if (CFG_BUS_RECONFIG_BOTTOMBUSSI == 1)
const u8 g_BottomBusSI[8] = {
	BOTBUS_SI_SLOT_1ST_ARM,
	BOTBUS_SI_SLOT_MALI,
	BOTBUS_SI_SLOT_DEINTERLACE,
	BOTBUS_SI_SLOT_1ST_CODA,
	BOTBUS_SI_SLOT_2ND_ARM,
	BOTBUS_SI_SLOT_SCALER,
	BOTBUS_SI_SLOT_TOP,
	BOTBUS_SI_SLOT_2ND_CODA
};
#endif

#if (CFG_BUS_RECONFIG_BOTTOMBUSQOS == 1)
const u8 g_BottomQoSSI[2] = {
	1,      // Tidemark
	(1<<BOTBUS_SI_SLOT_1ST_ARM) |   // Control
	(1<<BOTBUS_SI_SLOT_2ND_ARM) |
	(1<<BOTBUS_SI_SLOT_MALI) |
	(1<<BOTBUS_SI_SLOT_TOP) |
	(1<<BOTBUS_SI_SLOT_DEINTERLACE) |
	(1<<BOTBUS_SI_SLOT_1ST_CODA)
};
#endif

#if (CFG_BUS_RECONFIG_DISPBUSSI == 1)
const u8 g_DispBusSI[3] = {
	DISBUS_SI_SLOT_1ST_DISPLAY,
	DISBUS_SI_SLOT_2ND_DISPLAY,
	DISBUS_SI_SLOT_GMAC
};
#endif
#endif	/* #if (CFG_BUS_RECONFIG_ENB == 1) */

/*------------------------------------------------------------------------------
 * intialize nexell soc and board status.
 */
static void set_gpio_strenth(U32 Group, U32 BitNumber, U32 mA)
{
	U32 drv1=0, drv0=0;
	U32 drv1_value, drv0_value;

	switch( mA )
	{
		case 0 : drv0 = 0; drv1 = 0; break;
		case 1 : drv0 = 0; drv1 = 1; break;
		case 2 : drv0 = 1; drv1 = 0; break;
		case 3 : drv0 = 1; drv1 = 1; break;
		default: drv0 = 0; drv1 = 0; break;
	}
	DBGOUT("DRV Strength : GRP : i %x Bit: %x  ma :%d  \n",
				Group, BitNumber, mA);

	drv1_value = NX_GPIO_GetDRV1(Group) & ~(1 << BitNumber);
	drv0_value = NX_GPIO_GetDRV0(Group) & ~(1 << BitNumber);

	if (drv1) drv1_value |= (drv1 << BitNumber);
	if (drv0) drv0_value |= (drv0 << BitNumber);

	DBGOUT(" Value : drv1 :%8x  drv0 %8x \n ",drv1_value, drv0_value);

	NX_GPIO_SetDRV0 ( Group, drv0_value );
	NX_GPIO_SetDRV1 ( Group, drv1_value );
}

static void bd_gpio_init(void)
{
	int index, bit;
	int mode, func, out, lv, plup, stren;
	U32 gpio;

	const U32 pads[NUMBER_OF_GPIO_MODULE][32] = {
	{	/* GPIO_A */
	PAD_GPIOA0 , PAD_GPIOA1 , PAD_GPIOA2 , PAD_GPIOA3 , PAD_GPIOA4 , PAD_GPIOA5 , PAD_GPIOA6 , PAD_GPIOA7 , PAD_GPIOA8 , PAD_GPIOA9 ,
	PAD_GPIOA10, PAD_GPIOA11, PAD_GPIOA12, PAD_GPIOA13, PAD_GPIOA14, PAD_GPIOA15, PAD_GPIOA16, PAD_GPIOA17, PAD_GPIOA18, PAD_GPIOA19,
	PAD_GPIOA20, PAD_GPIOA21, PAD_GPIOA22, PAD_GPIOA23, PAD_GPIOA24, PAD_GPIOA25, PAD_GPIOA26, PAD_GPIOA27, PAD_GPIOA28, PAD_GPIOA29,
	PAD_GPIOA30, PAD_GPIOA31
	}, { /* GPIO_B */
	PAD_GPIOB0 , PAD_GPIOB1 , PAD_GPIOB2 , PAD_GPIOB3 , PAD_GPIOB4 , PAD_GPIOB5 , PAD_GPIOB6 , PAD_GPIOB7 , PAD_GPIOB8 , PAD_GPIOB9 ,
	PAD_GPIOB10, PAD_GPIOB11, PAD_GPIOB12, PAD_GPIOB13, PAD_GPIOB14, PAD_GPIOB15, PAD_GPIOB16, PAD_GPIOB17, PAD_GPIOB18, PAD_GPIOB19,
	PAD_GPIOB20, PAD_GPIOB21, PAD_GPIOB22, PAD_GPIOB23, PAD_GPIOB24, PAD_GPIOB25, PAD_GPIOB26, PAD_GPIOB27, PAD_GPIOB28, PAD_GPIOB29,
	PAD_GPIOB30, PAD_GPIOB31
	}, { /* GPIO_C */
	PAD_GPIOC0 , PAD_GPIOC1 , PAD_GPIOC2 , PAD_GPIOC3 , PAD_GPIOC4 , PAD_GPIOC5 , PAD_GPIOC6 , PAD_GPIOC7 , PAD_GPIOC8 , PAD_GPIOC9 ,
	PAD_GPIOC10, PAD_GPIOC11, PAD_GPIOC12, PAD_GPIOC13, PAD_GPIOC14, PAD_GPIOC15, PAD_GPIOC16, PAD_GPIOC17, PAD_GPIOC18, PAD_GPIOC19,
	PAD_GPIOC20, PAD_GPIOC21, PAD_GPIOC22, PAD_GPIOC23, PAD_GPIOC24, PAD_GPIOC25, PAD_GPIOC26, PAD_GPIOC27, PAD_GPIOC28, PAD_GPIOC29,
	PAD_GPIOC30, PAD_GPIOC31
	}, { /* GPIO_D */
	PAD_GPIOD0 , PAD_GPIOD1 , PAD_GPIOD2 , PAD_GPIOD3 , PAD_GPIOD4 , PAD_GPIOD5 , PAD_GPIOD6 , PAD_GPIOD7 , PAD_GPIOD8 , PAD_GPIOD9 ,
	PAD_GPIOD10, PAD_GPIOD11, PAD_GPIOD12, PAD_GPIOD13, PAD_GPIOD14, PAD_GPIOD15, PAD_GPIOD16, PAD_GPIOD17, PAD_GPIOD18, PAD_GPIOD19,
	PAD_GPIOD20, PAD_GPIOD21, PAD_GPIOD22, PAD_GPIOD23, PAD_GPIOD24, PAD_GPIOD25, PAD_GPIOD26, PAD_GPIOD27, PAD_GPIOD28, PAD_GPIOD29,
	PAD_GPIOD30, PAD_GPIOD31
	}, { /* GPIO_E */
	PAD_GPIOE0 , PAD_GPIOE1 , PAD_GPIOE2 , PAD_GPIOE3 , PAD_GPIOE4 , PAD_GPIOE5 , PAD_GPIOE6 , PAD_GPIOE7 , PAD_GPIOE8 , PAD_GPIOE9 ,
	PAD_GPIOE10, PAD_GPIOE11, PAD_GPIOE12, PAD_GPIOE13, PAD_GPIOE14, PAD_GPIOE15, PAD_GPIOE16, PAD_GPIOE17, PAD_GPIOE18, PAD_GPIOE19,
	PAD_GPIOE20, PAD_GPIOE21, PAD_GPIOE22, PAD_GPIOE23, PAD_GPIOE24, PAD_GPIOE25, PAD_GPIOE26, PAD_GPIOE27, PAD_GPIOE28, PAD_GPIOE29,
	PAD_GPIOE30, PAD_GPIOE31
	},
	};

	/* GPIO pad function */
	for (index = 0; NUMBER_OF_GPIO_MODULE > index; index++) {

		NX_GPIO_ClearInterruptPendingAll(index);

		for (bit = 0; 32 > bit; bit++) {
			gpio  = pads[index][bit];
			func  = PAD_GET_FUNC(gpio);
			mode  = PAD_GET_MODE(gpio);
			lv    = PAD_GET_LEVEL(gpio);
			stren = PAD_GET_STRENGTH(gpio);
			plup  = PAD_GET_PULLUP(gpio);

			/* get pad alternate function (0,1,2,4) */
			switch (func) {
			case PAD_GET_FUNC(PAD_FUNC_ALT0): func = NX_GPIO_PADFUNC_0;	break;
			case PAD_GET_FUNC(PAD_FUNC_ALT1): func = NX_GPIO_PADFUNC_1;	break;
			case PAD_GET_FUNC(PAD_FUNC_ALT2): func = NX_GPIO_PADFUNC_2;	break;
			case PAD_GET_FUNC(PAD_FUNC_ALT3): func = NX_GPIO_PADFUNC_3;	break;
			default: printf("ERROR, unknown alt func (%d.%02d=%d)\n", index, bit, func);
				continue;
			}

			switch (mode) {
			case PAD_GET_MODE(PAD_MODE_ALT): out = 0;
			case PAD_GET_MODE(PAD_MODE_IN ): out = 0;
			case PAD_GET_MODE(PAD_MODE_INT): out = 0; break;
			case PAD_GET_MODE(PAD_MODE_OUT): out = 1; break;
			default: printf("ERROR, unknown io mode (%d.%02d=%d)\n", index, bit, mode);
				continue;
			}

			NX_GPIO_SetPadFunction(index, bit, func);
			NX_GPIO_SetOutputEnable(index, bit, (out ? CTRUE : CFALSE));
			NX_GPIO_SetOutputValue(index, bit,  (lv  ? CTRUE : CFALSE));
			NX_GPIO_SetInterruptMode(index, bit, (lv));

			NX_GPIO_SetPullMode(index, bit, plup);
			set_gpio_strenth(index, bit, stren); /* pad strength */
		}

		NX_GPIO_SetDRV0_DISABLE_DEFAULT(index, 0xFFFFFFFF);
		NX_GPIO_SetDRV1_DISABLE_DEFAULT(index, 0xFFFFFFFF);
	}
}

static void bd_alive_init(void)
{
	int index, bit;
	int mode, out, lv, plup, detect;
	U32 gpio;

	const U32 pads[] = {
	PAD_GPIOALV0, PAD_GPIOALV1, PAD_GPIOALV2,
	PAD_GPIOALV3, PAD_GPIOALV4, PAD_GPIOALV5
	};

	index = sizeof(pads)/sizeof(pads[0]);

	/* Alive pad function */
	for (bit = 0; index > bit; bit++) {
		NX_ALIVE_ClearInterruptPending(bit);
		gpio = pads[bit];
		mode = PAD_GET_MODE(gpio);
		lv   = PAD_GET_LEVEL(gpio);
		plup = PAD_GET_PULLUP(gpio);

		switch (mode) {
		case PAD_GET_MODE(PAD_MODE_IN ):
		case PAD_GET_MODE(PAD_MODE_INT): out = 0; break;
		case PAD_GET_MODE(PAD_MODE_OUT): out = 1; break;
		case PAD_GET_MODE(PAD_MODE_ALT):
			printf("ERROR, alive.%d not support alt function\n", bit);
			continue;
		default :
			printf("ERROR, unknown alive mode (%d=%d)\n", bit, mode);
			continue;
		}

		NX_ALIVE_SetOutputEnable(bit, (out ? CTRUE : CFALSE));
		NX_ALIVE_SetOutputValue (bit, (lv));
		NX_ALIVE_SetPullUpEnable(bit, (plup & 1 ? CTRUE : CFALSE));
		/* set interrupt mode */
		for (detect = 0; 6 > detect; detect++) {
			if (mode == PAD_GET_MODE(PAD_MODE_INT))
				NX_ALIVE_SetDetectMode(detect, bit, (lv == detect ? CTRUE : CFALSE));
			else
				NX_ALIVE_SetDetectMode(detect, bit, CFALSE);
		}
		NX_ALIVE_SetDetectEnable(bit, (mode == PAD_MODE_INT ? CTRUE : CFALSE));
	}
}

/* call from u-boot */
int board_early_init_f(void)
{
	bd_gpio_init();
	bd_alive_init();
#if (defined(CONFIG_PMIC_NXE2000)||defined(CONFIG_PMIC_AXP228))&& !defined(CONFIG_PMIC_REG_DUMP)
	bd_pmic_init();
#endif
	return 0;
}

int board_init(void)
{
	DBGOUT("%s : done board init ...\n", CFG_SYS_BOARD_NAME);
	return 0;
}

#if defined(CONFIG_PMIC_NXE2000)||defined(CONFIG_PMIC_AXP228)
int power_init_board(void)
{
	int ret = 0;
#if defined(CONFIG_PMIC_REG_DUMP)
	bd_pmic_init();
#endif
	ret = power_pmic_function_init();
	return ret;
}
#endif

#ifdef CONFIG_CMD_NET
int bd_eth_init(void)
{
#if defined(CONFIG_DESIGNWARE_ETH)
	u32 addr;

#if 0	// 20140515
	// 100 & 10Base-T
	nxp_gpio_set_drv( (PAD_GPIO_E +  7), GPIO_DRV_1X );     // PAD_GPIOE7,     GMAC0_PHY_TXD[0]
	nxp_gpio_set_drv( (PAD_GPIO_E +  8), GPIO_DRV_1X );     // PAD_GPIOE8,     GMAC0_PHY_TXD[1]
	nxp_gpio_set_drv( (PAD_GPIO_E +  9), GPIO_DRV_1X );     // PAD_GPIOE9,     GMAC0_PHY_TXD[2]
	nxp_gpio_set_drv( (PAD_GPIO_E + 10), GPIO_DRV_1X );     // PAD_GPIOE10,    GMAC0_PHY_TXD[3]
	nxp_gpio_set_drv( (PAD_GPIO_E + 11), GPIO_DRV_1X );     // PAD_GPIOE11,    GMAC0_PHY_TXEN
//	nxp_gpio_set_drv( (PAD_GPIO_E + 12), GPIO_DRV_1X );     // PAD_GPIOE12,    GMAC0_PHY_TXER
//	nxp_gpio_set_drv( (PAD_GPIO_E + 13), GPIO_DRV_1X );     // PAD_GPIOE13,    GMAC0_PHY_COL
	nxp_gpio_set_drv( (PAD_GPIO_E + 14), GPIO_DRV_3X );     // PAD_GPIOE14,    GMAC0_PHY_RXD[0]
	nxp_gpio_set_drv( (PAD_GPIO_E + 15), GPIO_DRV_3X );     // PAD_GPIOE15,    GMAC0_PHY_RXD[1]
	nxp_gpio_set_drv( (PAD_GPIO_E + 16), GPIO_DRV_3X );     // PAD_GPIOE16,    GMAC0_PHY_RXD[2]
	nxp_gpio_set_drv( (PAD_GPIO_E + 17), GPIO_DRV_3X );     // PAD_GPIOE17,    GMAC0_PHY_RXD[3]
	nxp_gpio_set_drv( (PAD_GPIO_E + 18), GPIO_DRV_4X );     // PAD_GPIOE18,    GMAC0_RX_CLK
	nxp_gpio_set_drv( (PAD_GPIO_E + 19), GPIO_DRV_4X );     // PAD_GPIOE19,    GMAC0_PHY_RX_DV
	nxp_gpio_set_drv( (PAD_GPIO_E + 20), GPIO_DRV_4X );     // PAD_GPIOE20,    GMAC0_GMII_MDC
	nxp_gpio_set_drv( (PAD_GPIO_E + 21), GPIO_DRV_4X );     // PAD_GPIOE21,    GMAC0_GMII_MDI
//	nxp_gpio_set_drv( (PAD_GPIO_E + 22), GPIO_DRV_1X );     // PAD_GPIOE22,    GMAC0_PHY_RXER
//	nxp_gpio_set_drv( (PAD_GPIO_E + 23), GPIO_DRV_1X );     // PAD_GPIOE23,    GMAC0_PHY_CRS
	nxp_gpio_set_drv( (PAD_GPIO_E + 24), GPIO_DRV_1X );     // PAD_GPIOE24,    GMAC0_GTX_CLK

	NX_CLKGEN_SetClockOutInv( CLOCKINDEX_OF_DWC_GMAC_MODULE, 0, CFALSE);    // TX Clk invert off : 100 & 10Base-T
#endif

#if 1
	// 1000Base-T
	nxp_gpio_set_drv( (PAD_GPIO_E +  7), GPIO_DRV_4X );     // PAD_GPIOE7,     GMAC0_PHY_TXD[0]
	nxp_gpio_set_drv( (PAD_GPIO_E +  8), GPIO_DRV_4X );     // PAD_GPIOE8,     GMAC0_PHY_TXD[1]
	nxp_gpio_set_drv( (PAD_GPIO_E +  9), GPIO_DRV_4X );     // PAD_GPIOE9,     GMAC0_PHY_TXD[2]
	nxp_gpio_set_drv( (PAD_GPIO_E + 10), GPIO_DRV_4X );     // PAD_GPIOE10,    GMAC0_PHY_TXD[3]
	nxp_gpio_set_drv( (PAD_GPIO_E + 11), GPIO_DRV_4X );     // PAD_GPIOE11,    GMAC0_PHY_TXEN
//	nxp_gpio_set_drv( (PAD_GPIO_E + 12), GPIO_DRV_1X );     // PAD_GPIOE12,    GMAC0_PHY_TXER
//	nxp_gpio_set_drv( (PAD_GPIO_E + 13), GPIO_DRV_1X );     // PAD_GPIOE13,    GMAC0_PHY_COL
	nxp_gpio_set_drv( (PAD_GPIO_E + 14), GPIO_DRV_4X );     // PAD_GPIOE14,    GMAC0_PHY_RXD[0]
	nxp_gpio_set_drv( (PAD_GPIO_E + 15), GPIO_DRV_4X );     // PAD_GPIOE15,    GMAC0_PHY_RXD[1]
	nxp_gpio_set_drv( (PAD_GPIO_E + 16), GPIO_DRV_4X );     // PAD_GPIOE16,    GMAC0_PHY_RXD[2]
	nxp_gpio_set_drv( (PAD_GPIO_E + 17), GPIO_DRV_4X );     // PAD_GPIOE17,    GMAC0_PHY_RXD[3]
	nxp_gpio_set_drv( (PAD_GPIO_E + 18), GPIO_DRV_4X );     // PAD_GPIOE18,    GMAC0_RX_CLK
	nxp_gpio_set_drv( (PAD_GPIO_E + 19), GPIO_DRV_4X );     // PAD_GPIOE19,    GMAC0_PHY_RX_DV
	nxp_gpio_set_drv( (PAD_GPIO_E + 20), GPIO_DRV_4X );     // PAD_GPIOE20,    GMAC0_GMII_MDC
	nxp_gpio_set_drv( (PAD_GPIO_E + 21), GPIO_DRV_4X );     // PAD_GPIOE21,    GMAC0_GMII_MDI
//	nxp_gpio_set_drv( (PAD_GPIO_E + 22), GPIO_DRV_1X );     // PAD_GPIOE22,    GMAC0_PHY_RXER
//	nxp_gpio_set_drv( (PAD_GPIO_E + 23), GPIO_DRV_1X );     // PAD_GPIOE23,    GMAC0_PHY_CRS
	nxp_gpio_set_drv( (PAD_GPIO_E + 24), GPIO_DRV_4X );     // PAD_GPIOE24,    GMAC0_GTX_CLK

	NX_CLKGEN_SetClockOutInv( CLOCKINDEX_OF_DWC_GMAC_MODULE, 0, CFALSE);    // TX Clk invert off
#endif

	// Clock control
	NX_CLKGEN_Initialize();
	addr = NX_CLKGEN_GetPhysicalAddress(CLOCKINDEX_OF_DWC_GMAC_MODULE);
	NX_CLKGEN_SetBaseAddress( CLOCKINDEX_OF_DWC_GMAC_MODULE, (u32)IO_ADDRESS(addr) );

	NX_CLKGEN_SetClockSource( CLOCKINDEX_OF_DWC_GMAC_MODULE, 0, 4);     // Sync mode for 100 & 10Base-T : External RX_clk
	NX_CLKGEN_SetClockDivisor( CLOCKINDEX_OF_DWC_GMAC_MODULE, 0, 1);    // Sync mode for 100 & 10Base-T

	NX_CLKGEN_SetClockOutInv( CLOCKINDEX_OF_DWC_GMAC_MODULE, 0, CFALSE);    // TX Clk invert off : 100 & 10Base-T
//	NX_CLKGEN_SetClockOutInv( CLOCKINDEX_OF_DWC_GMAC_MODULE, 0, CTRUE);     // TX clk invert on : 100 & 10Base-T

	NX_CLKGEN_SetClockDivisorEnable( CLOCKINDEX_OF_DWC_GMAC_MODULE, CTRUE);

	// Reset control
	NX_RSTCON_Initialize();
	addr = NX_RSTCON_GetPhysicalAddress();
	NX_RSTCON_SetBaseAddress( (u32)IO_ADDRESS(addr) );
	NX_RSTCON_SetnRST(RESETINDEX_OF_DWC_GMAC_MODULE_aresetn_i, RSTCON_ENABLE);
	udelay(100);
	NX_RSTCON_SetnRST(RESETINDEX_OF_DWC_GMAC_MODULE_aresetn_i, RSTCON_DISABLE);
	udelay(100);
	NX_RSTCON_SetnRST(RESETINDEX_OF_DWC_GMAC_MODULE_aresetn_i, RSTCON_ENABLE);
	udelay(100);

	// Set interrupt config.
	nxp_gpio_set_pull_sel(CFG_ETHER_GMAC_PHY_IRQ_NUM, CTRUE);
	nxp_gpio_set_pull_enb(CFG_ETHER_GMAC_PHY_IRQ_NUM, CTRUE);
	gpio_direction_input(CFG_ETHER_GMAC_PHY_IRQ_NUM);

	// Set GPIO nReset
	nxp_gpio_set_pull_enb(CFG_ETHER_GMAC_PHY_RST_NUM, CFALSE);
	gpio_direction_output(CFG_ETHER_GMAC_PHY_RST_NUM, 1 );
	udelay( 100 );
	gpio_set_value(CFG_ETHER_GMAC_PHY_RST_NUM, 0 );
	udelay( 100 );
	gpio_set_value(CFG_ETHER_GMAC_PHY_RST_NUM, 1 );
#endif	// #if defined(CONFIG_DESIGNWARE_ETH)

	return 0;
}
#endif	/* CONFIG_CMD_NET */

int board_late_init(void)
{
#ifdef CONFIG_CMD_NET
	bd_eth_init();
#endif

	return 0;
}

#if defined(CFG_FASTBOOT_PTABLE_USERDEFINE)
struct ptable_userdefine user_ptables[] = {
	{
		.type = BOOT_DEV_TYPE_EEPROM,
		.name = "2ndboot",
		.start = 0,
		.length = 0,
	},
	{
		.type = BOOT_DEV_TYPE_EEPROM,
		.name = "bootloader",
		.start = 64*1024*1024,
		.length = 0,
	},
	{
		.type = BOOT_DEV_TYPE_SDMMC,
		.partno = 1,
		.pid = 0x83,
		.name = "boot",
	},
	{
		.type = BOOT_DEV_TYPE_SDMMC,
		.partno = 2,
		.pid = 0x83,
		.name = "system",
	},
	{
		.type = BOOT_DEV_TYPE_SDMMC,
		.partno = 3,
		.pid = 0x83,
		.name = "cache",
	},
	{
		.type = BOOT_DEV_TYPE_SDMMC,
		.partno = 4,
		.pid = 0x83,
		.name = "userdata",
	},
	{
		.type = BOOT_DEV_TYPE_NONE,
	},
};
#endif
