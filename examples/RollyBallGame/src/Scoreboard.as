package
{
    import com.pblabs.engine.core.*;
    import com.pblabs.engine.resource.*;
    import com.pblabs.rendering2D.ui.PBButton;
    import com.pblabs.rendering2D.ui.PBLabel;
    import com.pblabs.screens.ScreenManager;
    
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;
    import flash.geom.*;
    import flash.text.*;

    public class Scoreboard extends Sprite
    {
        public var lblScore:PBLabel = new PBLabel();
        public var btnContinue:PBButton = new PBButton();
        public var btnRetry:PBButton = new PBButton();
        
        public var CoinsLeft:int, TotalScore:int;
        public var ScoreIncrementSound:Sound;

        public function Scoreboard()
        {
            ResourceManager.instance.load("../Assets/Sounds/scorechunk.mp3", MP3Resource, _OnSound);

            addChild(lblScore);
            lblScore.extents = new Rectangle(50, 80, 490, 50);
            lblScore.fontSize = 48;
            lblScore.fontAlign = TextFormatAlign.CENTER;
            lblScore.fontColor = 0xFFFF00;
            lblScore.refresh();
            
            addChild(btnContinue);
            btnContinue.extents = new Rectangle(320, 480-64, 200, 50);
            btnContinue.caption = "Continue >>";
            btnContinue.fontColor = 0xFFFFFF;
            btnContinue.color = 0x00FF00;
            btnContinue.refresh();
            
            addChild(btnRetry);
            btnRetry.extents = new Rectangle(60, 480-64, 200, 50);
            btnRetry.caption = "<< Retry";
            btnRetry.fontColor = 0xFFFFFF;
            btnRetry.color = 0xFF0000;
            btnRetry.refresh();
            
            btnContinue.addEventListener(MouseEvent.CLICK, _OnNextClick);
            btnRetry.addEventListener(MouseEvent.CLICK, _OnRetryClick);            
        }
        
        public function StartReport(numCoins:int):void
        {
            CoinsLeft = numCoins;
            TotalScore = 0;
            
            lblScore.caption = "Total Score: ";
            lblScore.refresh();
            
            setTimeout(_DoNextCoin, 500);
        }
        
        private function _DoNextCoin():void
        {
            if(CoinsLeft <= 0)
                return;
            
            // Play a pleasing chunk noise when score goes up.
            if(ScoreIncrementSound)
                ScoreIncrementSound.play();
            
            // Update our state.
            CoinsLeft--;
            TotalScore += 1000;
            lblScore.caption = "Total Score: " + TotalScore;
            lblScore.refresh();
            setTimeout(_DoNextCoin, Math.min(1000 / CoinsLeft, 250));
        }
        
        private function _OnRetryClick(e:Event):void
        {
            RollyBallGame.resetLevel();
            parent.removeChild(this);
        }
        
        private function _OnNextClick(e:Event):void
        {
            RollyBallGame.nextLevel();
            parent.removeChild(this);
        }
        
        private function _OnSound(mp3:MP3Resource):void
        {
            ScoreIncrementSound = mp3.soundObject;
        }        
    }
}