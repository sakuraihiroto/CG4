#pragma once
#include "Sprite.h"

class PostEffect :
    public Sprite
{
public:

    PostEffect();

    void Initialize();

    void PreDrawScene(ID3D12GraphicsCommandList* cmdList);

    void PostDrawScene(ID3D12GraphicsCommandList* cmdList);

    void CreateGraphicsPipelineState();

    void Draw(ID3D12GraphicsCommandList* cmdList);

private: //�����o�ϐ�

    //�e�N�X�`���o�b�t�@
    ComPtr<ID3D12Resource> texBuff[2];
    //SRV�p�f�X�N���v�^�q�[�v
    ComPtr<ID3D12DescriptorHeap> descHeapSRV;
    //�[�x�o�b�t�@
    ComPtr<ID3D12Resource> depthBuff;
    //RTV�p�f�X�N���v�^�q�[�v
    ComPtr<ID3D12DescriptorHeap> descHeapRTV;
    //DSV�p�f�X�N���v�^�q�[�v
    ComPtr<ID3D12DescriptorHeap> descHeapDSV;
    //�O���t�B�b�N�X�p�C�v���C��
    ComPtr<ID3D12PipelineState> pipelineState;
    //���[�g�V�O�l�`��
    ComPtr<ID3D12RootSignature> rootSignature;

private: //�ÓI�����o�ϐ�

    static const float clearColor[4];

};

