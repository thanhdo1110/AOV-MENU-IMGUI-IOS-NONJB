#import <UIKit/UIKit.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#import "Esp/CaptainHook.h"
#import "Esp/ImGuiDrawView.h"
#import "IMGUI/imgui.h"
#import "IMGUI/imgui_impl_metal.h"
#import "IMGUI/zzz.h"
#import "Esp/MonoString.h"
#include "Esp/dbdef.h"
#include "1110/patch.h"
#include "1110/haizzz.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale


@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation ImGuiDrawView
#include "1110/hook.h"


static bool show_s0 = false;


static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsClassic();
    
    ImFont* font = io.Fonts->AddFontFromMemoryCompressedTTF((void*)zzz_compressed_data, zzz_compressed_size, 60.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{

 

    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;

    //hook
    HOOK(ENCRYPTOFFSET("0x61E0F48"), _cam, cam); // private float GetCameraHeightRateValue(int type) { }
    HOOK(ENCRYPTOFFSET("0x61DFF50"), _Update, Update); // private void Update() { }
    HOOK(ENCRYPTOFFSET("0x61E1370"), _highrate, highrate); // 	private void OnCameraHeightChanged() { }
    HOOK(ENCRYPTOFFSET("0x59EC6F4"), IsSmartUse, _IsSmartUse); // public bool IsSmartUse() { }
    HOOK(ENCRYPTOFFSET("0x57CC0F4"), get_IsUseCameraMoveWithIndicator, _get_IsUseCameraMoveWithIndicator); // public void ShowSkillStateInfo(bool bShow) { }
    HOOK(ENCRYPTOFFSET("0x64C773C"), IsDistanceLowerEqualAsAttacker, old_IsDistanceLowerEqualAsAttacker); //public bool IsDistanceLowerEqualAsAttacker(ActorLinker targetActor, int radius) { }
    HOOK(ENCRYPTOFFSET("0x5AD7B84"), IsUseSkillJoystick, _IsUseSkillJoystick); // public bool IsUseSkillJoystick(SkillSlotType slot) { }
    HOOK(ENCRYPTOFFSET("0x5A6A764"), SetPlayerName, old_SetPlayerName); // public void SetPlayerName(string playerName, string prefixName = "", bool isGuideLevel = False) { }
    HOOK(ENCRYPTOFFSET("0x547FB70"), _Autowin, Autowin); // public void SetHpAndEpToInitialValue(int hpPercent = 10000, int epPercent = 10000) { }
    HOOK(ENCRYPTOFFSET("0x53AC920"), LActorRoot_Visible, _LActorRoot_Visible); //public bool SetVisible(COM_PLAYERCAMP camp, bool bVisible, bool forceSync = False) { }
}



#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{
   
    
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 120);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    

//Define your bool/function in here
    static bool ctdotech_s1 = true;    
    static bool ctdotech_s2 = true;  
    static bool ctdotech_s3 = true;  
    static bool ctdotech_s4 = true;  
    static bool ctdotech_s5 = true;  
//Define active function
    static bool ctdotech_s1_active = false;
    static bool ctdotech_s2_active = false;
    static bool ctdotech_s3_active = false;
    static bool ctdotech_s4_active = false;
    static bool ctdotech_s5_active = false;
    
        
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 15.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 300) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(400, 300), ImGuiCond_FirstUseEver);
            
            if (MenDeal == true)
            {                
                ImGui::Begin("Menu AOV Nonjb #1110", &MenDeal);

            
                if (ImGui::BeginTabBar("MainTabBar"))  
                {
                    if (ImGui::BeginTabItem("Function"))
                    {
                        ImGui::Checkbox("Hack Map", &Map);
                        ImGui::SameLine();
                        ImGui::Checkbox("Hiện Lịch Sử Đấu", &ctdotech_s1);
                        ImGui::SameLine();
                        ImGui::Checkbox("Auto Win", &AutoWinInGame);
                        ImGui::Checkbox("Hiện Bổ Trợ", &ctdotech_s2);
                        ImGui::SameLine();
                        ImGui::Checkbox("Hiện Ulti", &ctdotech_s3);
                        ImGui::SameLine();
                        ImGui::Checkbox("Ẩn Tên", &isPlayerName);
                        ImGui::Checkbox("Hiện Rank", &ctdotech_s4);
                        ImGui::SameLine();
                        ImGui::Checkbox("Khóa Camera", &lockcam);
                        ImGui::SliderFloat("Độ Cao Camera", &SetFieldOfView, 0.1, 10);
                        ImGui::EndTabItem();  
                    }

                   
                    if (ImGui::BeginTabItem("Aim Settings"))
                    {
                        ImGui::TextWrapped("Aim Elsu: Bật Aim 2.0, chiêu 2. Set tầm aim 25 là chuẩn nhất"); 
                        ImGui::Checkbox("Aim 2.0", &AimSkill);
                        ImGui::Checkbox("Auto Aim", &AutoTrung);
                        ImGui::Checkbox("Aim Skill 1", &aimSkill1);
                        ImGui::Checkbox("Aim Skill 2", &aimSkill2);
                        ImGui::Checkbox("Aim Skill 3", &aimSkill3);
                        ImGui::Text("Line Aim");
                        ImGui::SliderInt(" ", &Radius, 0, 100, "%dm");
                        ImGui::EndTabItem();  
                    }

                    ImGui::EndTabBar();  
                }

                ImGui::End(); 
            }

            ImDrawList* draw_list = ImGui::GetBackgroundDrawList();




            if(ctdotech_s1){
                if(ctdotech_s1_active == NO){
                    ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5CE522C , "0x200080D2C0035FD6");  //Hiện lsđ     
                    //Patch
                    Hook1110("Frameworks/UnityFramework.framework/UnityFramework",  0x5CE522C , "0x200080D2C0035FD6");
                    }
                ctdotech_s1_active = YES;
            }
            else{ 
                if(ctdotech_s1_active == YES){
                    DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5CE522C , "0x200080D2C0035FD6");
                    }
                ctdotech_s1_active = NO;
            }   

//Hiện Bổ Trợ
            if(ctdotech_s2){
                if(ctdotech_s2_active == NO){
                    ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x606BF94 , "0x1F2003D5");          
                    //Patch
                    Hook1110("Frameworks/UnityFramework.framework/UnityFramework",  0x606BF94 , "0x1F2003D5");         
                    }
                ctdotech_s2_active = YES;
            }
            else{ 
                if(ctdotech_s2_active == YES){
                    DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x606BF94 , "0x1F2003D5");       
                    }
                ctdotech_s2_active = NO;
            }  

//Hiện Ulti 2 & 1
            if(ctdotech_s3){
                if(ctdotech_s3_active == NO){
                    ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5EB969C , "0x1F2003D5");         
                    ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5EB972C , "0x330080D2");           
                    //Patch
                    Hook1110("Frameworks/UnityFramework.framework/UnityFramework",  0x5EB969C , "0x1F2003D5");      
                    Hook1110("Frameworks/UnityFramework.framework/UnityFramework",  0x5EB972C , "0x330080D2");          
                    }
                ctdotech_s3_active = YES;
            }
            else{ 
                if(ctdotech_s3_active == YES){
                    DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5EB969C , "0x1F2003D5");         
                    DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5EB972C , "0x330080D2");               
                    }
                ctdotech_s3_active = NO;
            } 

//Hiện Rank   
            if(ctdotech_s4){
                if(ctdotech_s4_active == NO){
                    ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5F95130 , "0x1F2003D5");              
                    //Patch
                    Hook1110("Frameworks/UnityFramework.framework/UnityFramework",  0x5F95130 , "0x1F2003D5");           
                    }
                ctdotech_s4_active = YES;
            }
            else{ 
                if(ctdotech_s4_active == YES){
                    DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5F95130 , "0x1F2003D5");        
                    }
                ctdotech_s4_active = NO;
            }  

//Fix fps  
            if(ctdotech_s5){
                if(ctdotech_s5_active == NO){
                    ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5EE95A0 , "0xC0035FD6");                 
                    //Patch
                    Hook1110("Frameworks/UnityFramework.framework/UnityFramework",  0x5EE95A0 , "0xC0035FD6");       
                    }
                ctdotech_s5_active = YES;
            }
            else{ 
                if(ctdotech_s5_active == YES){
                    DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework",  0x5EE95A0 , "0xC0035FD6");        
                    }
                ctdotech_s5_active = NO;
            } 

            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}

@end

