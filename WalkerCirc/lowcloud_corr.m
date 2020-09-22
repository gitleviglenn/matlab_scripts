
low_cld  =ncread(source_general,'low_cld_amt');
high_cld =ncread(source_general,'high_cld_amt');
%conv_p   =ncread(source_general,'prec_conv');
conv_p   =ncread(source_general,'prec_ls');

low_cld_a=squeeze(mean(low_cld,1));
low_cld_b=squeeze(mean(low_cld_a,1));
%low_cld_b;
high_cld_a=squeeze(mean(high_cld,1));
high_cld_b=squeeze(mean(high_cld_a,1));
%high_cld_b
conv_p_a=squeeze(mean(conv_p,1));
conv_p_b=squeeze(mean(conv_p_a,1));
%conv_p_b


'correlation of conv precip and low clouds'
cor1=corrcoef(conv_p_b,low_cld_b);
cor1(2,1)
'correlation of conv precip and high clouds'
cor2=corrcoef(conv_p_b,high_cld_b);
cor2(2,1)
%
%clear low_cld,high_cld,conv_p
%clear low_cld_b,high_cld_b,conv_p_b
%clear cor1,cor2
%


