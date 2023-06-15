#include "PostEffectTest.hlsli"

Texture2D<float4> tex : register(t0);  // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);      // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
	//平均ぼかし
	float4 texcolor = tex.Sample(smp,input.uv);
	//U座標1pixel分の変化量
	float2 u = 1.0f / 1280.0f;
	//V座標1pixel分の変化量
	float2 v = 1.0f / 720.0f;
	//横のマス目数
	int x = 5;
	//縦のマス目数
	int y = 5;
	//色合計変数を{0,0,0,0}で初期化
	texcolor = (0,0,0,0);
	//縦方向に移動しながら繰り返す
	for (int j = -y / 2; j <= y / 2; j++)
	{
		//横方向に移動しながら繰り返す
		for (int i = -x / 2; i <= x / 2; i++)
		{
			//ピクセルの色をサンプリングし,合計に足す
			texcolor.rgb += tex.Sample(smp, input.uv + (i * u) + (j * v));
		}
	}
	//合計色を縦x横のマス目数で割ってreturn(平均値)
	return float4(texcolor.rgb / (x * y), 1);
}